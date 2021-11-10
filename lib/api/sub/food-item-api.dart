import '../apiConn.dart' show APIConn;

class FoodItemApi {
  static final _conn = APIConn();

  // Getters
  // Get all food items
  Future<dynamic> getAllFoodItems() async {
    try {
      var response = await _conn.get("/api/food-item/food-items-all");
      return response;
    } catch (error) {
      throw error;
    }
  }

  // Get all categories
  Future<dynamic> getAllCategories() async {
    try {
      var response = await _conn.get("/api/food-item/categories-all");
      return response;
    } catch (error) {
      throw error;
    }
  }
}
