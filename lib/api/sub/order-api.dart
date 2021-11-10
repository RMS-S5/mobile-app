import '../apiConn.dart' show APIConn;

class OrderAPI {
  static final _conn = APIConn();

  // Post requests
  // Add order
  Future<dynamic> addOrder(dynamic orderData, {String? token}) async {
    try {
      var response = await _conn.post("/api/order/add-order",
          body: orderData, token: token);
      return response;
    } catch (error) {
      throw error;
    }
  }

  // Update Request
  // Update order - order data (..)
  Future<dynamic> updateOrder(String orderId, dynamic orderData,
      {String? token}) async {
    try {
      var response = await _conn.put("/api/order/order/$orderId",
          body: orderData, token: token);
      return response;
    } catch (error) {
      throw error;
    }
  }

  // Update order status -> staff
  Future<dynamic> updateOrdersStatus(orderData, {String? token}) async {
    try {
      var response = await _conn.put("/api/order/orders-status",
          body: orderData, token: token);
      return response;
    } catch (error) {
      throw error;
    }
  }

  // Get requests
// Get active orders -> staff
  Future<dynamic> getActiveOrders(
      {String? token, Map<String, dynamic>? query}) async {
    try {
      var response = await _conn.get("/api/order/active-orders",
          token: token, query: query);
      return response;
    } catch (error) {
      throw error;
    }
  }

  // Get table orders -> Customer, guest user
  Future<dynamic> getTableOrders({
    Map<String, dynamic>? query,
    String? token,
  }) async {
    try {
      var response = await _conn.get("/api/order/table-orders", query: query);
      return response;
    } catch (error) {
      throw error;
    }
  }
}
