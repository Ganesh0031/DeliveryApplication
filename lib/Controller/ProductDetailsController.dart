
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Response/CategoriesListResponse.dart';
import 'CartController.dart';

class ProductDetailsController extends GetxController {
  final CategoriesListResponse product;

  ProductDetailsController(this.product);

  var quantity = 0.obs;
  var selectedTab = 0.obs;
  var isLiked = false.obs;


  var selectedColor = Colors.black.obs;

  final CartController cartController = Get.find<CartController>();

  void increaseQty() => quantity.value++;
  void decreaseQty() {
    if (quantity.value > 1) quantity.value--;
  }

  void changeTab(int index) {
    selectedTab.value = index;
  }

  void changeColor(Color color) {
    selectedColor.value = color;
  }
  void addToCart() {
    cartController.addToCart(product, quantity.value);

    Get.snackbar(
      "Success",
      "Product added to cart successfully",
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.black,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 16,
      icon: const Icon(Icons.check_circle, color: Colors.green),
      duration: const Duration(seconds: 2),
    );
  }


}
