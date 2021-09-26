import "./sub/user-api.dart";
import "./sub/food-item-api.dart";
import "./sub/order-api.dart";
import "./sub/cart-api.dart";
import "./sub/branch-api.dart";

class API {
  static final userAPI = UserAPI();
  static final cartAPI = CartAPI();
  static final orderAPI = OrderAPI();
  static final foodItemAPI = FoodItemApi();
  static final branchAPI = BranchAPI();
  API._internal();
}
