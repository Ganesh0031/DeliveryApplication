import 'CategoriesListResponse.dart';

class CartItem {
  final CategoriesListResponse product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}
