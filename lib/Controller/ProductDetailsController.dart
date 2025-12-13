
import 'package:get/get.dart';
import '../Response/CategoriesListResponse.dart';
import 'CartController.dart';

class ProductDetailsController extends GetxController {
  final CategoriesListResponse item;

  ProductDetailsController(this.item);

  // Start with quantity 1 instead of 0
  RxInt quantity = 1.obs;

  var selectedTab = 0.obs;

  final cartController = Get.find<CartController>();

  void increaseQty() {
    quantity++;
  }

  void decreaseQty() {
    if (quantity > 1) {
      quantity--;
    }
  }

  void addToCart() {
    if (quantity.value > 0) {
      cartController.addToCart(item, quantity.value);
      // Reset quantity to 1 after adding to cart
      quantity.value = 1;
    }
  }

  void changeTab(int value) {
    selectedTab.value = value;
  }
}