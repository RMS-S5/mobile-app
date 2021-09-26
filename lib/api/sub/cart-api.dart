import '../apiConn.dart' show APIConn;

class CartAPI {
  static final _conn = APIConn();

  // Post
  Future<dynamic> addCart({String? token}) async {
    try {
      var response = await _conn.post("/api/cart/add-cart", token: token);
      return response;
    } catch (error) {
      throw error;
    }
  }

  Future<dynamic> addCartItem(dynamic cartItemData, {String? token}) async {
    try {
      var response = await _conn.post("/api/cart/add-cart-item",
          body: cartItemData, token: token);
      return response;
    } catch (error) {
      throw error;
    }
  }

  /**
   * Getters
   */
  Future<dynamic> getCartDataByCartId(String cartId) async {
    try {
      var response = await _conn.get("/api/cart/cart-data/$cartId");
      return response;
    } catch (error) {
      throw error;
    }
  }

  Future<dynamic> getCustomerCart(String customerId, {String? token}) async {
    try {
      var response =
          await _conn.get("/api/cart/customer-cart/$customerId", token: token);
      return response;
    } catch (error) {
      throw error;
    }
  }

  Future<dynamic> getCartItems(String cartId) async {
    try {
      var response = await _conn.get("/api/cart/cart-items/$cartId");
      return response;
    } catch (error) {
      throw error;
    }
  }

  // Remove
  Future<dynamic> removeCartItems(String cartIemId, {String? token}) async {
    try {
      var response =
          await _conn.delete("/api/cart/cart-item/$cartIemId", token: token);
      return response;
    } catch (error) {
      throw error;
    }
  }
}
