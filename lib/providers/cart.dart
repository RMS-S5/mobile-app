import 'package:flutter/foundation.dart';
import 'package:rms_mobile_app/models/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';

import '../api/api.dart';

class Cart with ChangeNotifier {
  String _cartId = "";

  List _cartItems = [];

  String _token;

  Cart(this._token, previousCartItems) {
    this._cartItems = previousCartItems;
  }

  // Getters
  List get cartItems {
    return [..._cartItems];
  }

  String get cartId {
    return _cartId;
  }

  List get cartItemsIds {
    return _cartItems.map((cartItem) => cartItem['cartItemId']).toList();
  }

  int get itemCount {
    return _cartItems.length;
  }

  double get totalAmount {
    var total = 0.0;
    _cartItems.forEach((cartItem) {
      total += double.parse(cartItem["price"]);
    });
    return total;
  }

  // Check whether there exist a cart id or create a new one
  Future<void> checkAndSetCart() async {
    if (_cartId != null && _cartId != "") {
      return;
    }
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('cartId')) {
        final response = await API.cartAPI.addCart(token: _token);
        _cartId = response['data']['cartId'] ?? "";
        if (_cartId != "") {
          await prefs.setString('cartId', _cartId);
        }
      }
      _cartId = prefs.getString('cartId') ?? "";
    } catch (error) {
      print(error);
      throw error;
    }
  }

  // Fetch and set cart items of cart
  Future<void> fetchAndSetCartItemsData() async {
    try {
      await checkAndSetCart();
      final response = await API.cartAPI.getCartItems(_cartId);
      _cartItems = response['data'] ?? [];
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  // Add cart item to cart
  Future<void> addCartItem(String foodItemId, dynamic price, dynamic quantity,
      {String? variantId}) async {
    try {
      await checkAndSetCart();
      var actualPrice;
      try {
        actualPrice = double.parse(price) * quantity;
      } catch (error) {
        actualPrice = price * quantity;
      }
      print(_cartId);
      var cartItemData = {
        'foodItemId': foodItemId,
        'price': actualPrice,
        'quantity': quantity,
        'cartId': _cartId
      };
      if (variantId != null && variantId != "") {
        cartItemData = {...cartItemData, 'variantId': variantId};
      }

      final response =
          await API.cartAPI.addCartItem(cartItemData, token: _token);

      final cartItemId = response['data']['cartItemId'] ?? "";

      if (cartItemId != "") {
        _cartItems.add({
          "cartItemId": cartItemId,
          "foodItemId": foodItemId,
          "variantId": variantId,
          "price": price,
          "quantity": quantity,
          "cartId": _cartId
        });
        notifyListeners();
      }
    } catch (error) {
      throw error;
    }
  }

  // Remove cart item from cart
  Future<void> removeItem(String cartItemId) async {
    try {
      final response =
          await API.cartAPI.removeCartItems(cartItemId, token: _token);
      _cartItems
          .removeWhere((cartItem) => cartItem['cartItemId'] == cartItemId);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  // Clear the cart
  void clear() {
    _cartItems = [];
    notifyListeners();
  }
}
