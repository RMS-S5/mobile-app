import '../apiConn.dart' show APIConn;

class CartAPI {
  static final _conn = APIConn();

  // Post
  // Add cart api
  Future<dynamic> addCart({String? token}) async {
    try {
      var response = await _conn.post("/api/cart/add-cart", token: token);
      return response;
    } catch (error) {
      throw error;
    }
  }

// Add cart item api
  Future<dynamic> addCartItem(dynamic cartItemData, {String? token}) async {
    try {
      var response = await _conn.post("/api/cart/add-cart-item",
          body: cartItemData, token: token);
      return response;
    } catch (error) {
      throw error;
    }
  }

  // Getters
  // Get cart data by cart id
  Future<dynamic> getCartDataByCartId(String cartId) async {
    try {
      var response = await _conn.get("/api/cart/cart-data/$cartId");
      return response;
    } catch (error) {
      throw error;
    }
  }

  // Get cart belongs to customer
  Future<dynamic> getCustomerCart(String customerId, {String? token}) async {
    try {
      var response =
          await _conn.get("/api/cart/customer-cart/$customerId", token: token);
      return response;
    } catch (error) {
      throw error;
    }
  }

  // Get cart items for given cart
  Future<dynamic> getCartItems(String cartId) async {
    try {
      var response = await _conn.get("/api/cart/cart-items/$cartId");
      return response;
    } catch (error) {
      throw error;
    }
  }

  // Remove cart item
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
