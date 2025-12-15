
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Presenter/CategoriesListPresenter.dart';
import '../Response/CategoriesListResponse.dart';
import '../Views/MVPView.dart';

class HomeController extends GetxController implements CategoriesListGetView {

  // Banner
  final PageController bannerController = PageController();

  final bannerImages = [
    "assets/real/banner1.png",
    "assets/real/banner2.jpg",
    "assets/real/banner3.jpg",
    "assets/real/banner5.jpg"
  ];

  // Categories
  final categories = <Map<String, dynamic>>[
    {"icon": Icons.devices_other, "name": "electronics"},
    {"icon": Icons.diamond_outlined, "name": "jewelery"},
    {"icon": Icons.man, "name": "men's clothing"},
    {"icon": Icons.woman, "name": "women's clothing"},
  ];

  var selectedCategory = 0.obs;

  // Data
  var allProducts = <CategoriesListResponse>[].obs;
  var filteredProducts = <CategoriesListResponse>[].obs;

  var isLoading = false.obs;

  late CategoriesListPresenter presenter;

  @override
  void onInit() {
    super.onInit();
    presenter = CategoriesListPresenter(this);
    fetchProducts(categories[0]["name"]);
  }

  void changeCategory(int index) {
    selectedCategory.value = index;
    fetchProducts(categories[index]["name"]);
  }

  void fetchProducts(String category) {
    presenter.getCategoriesListData(category);
  }

  void searchProduct(String query) {
    if (query.isEmpty) {
      filteredProducts.assignAll(allProducts);
    } else {
      filteredProducts.assignAll(
        allProducts.where(
              (item) => item.title!
              .toLowerCase()
              .contains(query.toLowerCase()),
        ).toList(),
      );
    }
  }


  @override
  void showCategoriesListDataGetResponse(
      List<CategoriesListResponse> response) {
    allProducts.assignAll(response);
    filteredProducts.assignAll(response);
  }

  @override
  void showLoading() => isLoading.value = true;

  @override
  void hideLoading() => isLoading.value = false;

  @override
  void showError(String message) {}
}
