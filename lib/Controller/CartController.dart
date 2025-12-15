
import 'package:currency_converter/Response/CartItem.dart';
import 'package:get/get.dart';
import '../Response/CategoriesListResponse.dart';

class CartController extends GetxController {
  var cartList = <CartItem>[].obs;

  void addToCart(CategoriesListResponse product, int quantity) {
    int index = cartList.indexWhere((item) => item.product.id == product.id);

    if (index != -1) {

      cartList[index].quantity += quantity;
    } else {
      cartList.add(CartItem(product: product, quantity: quantity));
    }
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