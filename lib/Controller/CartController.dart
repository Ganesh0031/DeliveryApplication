
import 'package:currency_converter/Response/CartItem.dart';
import 'package:get/get.dart';
import '../Response/CategoriesListResponse.dart';

class CartController extends GetxController {
  var cartList = <CartItem>[].obs;

  void addToCart(CategoriesListResponse product, int quantity) {
    // Find if product already exists in cart
    int index = cartList.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {
      // Product exists, increase quantity
      cartList[index].quantity += quantity;
    } else {
      // Product doesn't exist, add new item
      cartList.add(CartItem(product: product, quantity: quantity));
    }

    // Refresh the list to update UI
    cartList.refresh();
  }

  void increaseQty(int index) {
    cartList[index].quantity++;
    cartList.refresh();
  }

  void decreaseQty(int index) {
    if (cartList[index].quantity > 1) {
      cartList[index].quantity--;
      cartList.refresh();
    } else {
      // If quantity is 1, remove item from cart
      cartList.removeAt(index);
    }
  }

  void removeFromCart(int index) {
    cartList.removeAt(index);
  }

  // Calculate total price
  double get total {
    double sum = 0;
    for (var item in cartList) {
      sum += (item.product.price ?? 0) * item.quantity;
    }
    return sum;
  }

  // Get total items count
  int get totalItems {
    int count = 0;
    for (var item in cartList) {
      count += item.quantity;
    }
    return count;
  }

  // Clear cart
  void clearCart() {
    cartList.clear();
  }
}