import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Presenter/CategoriesListPresenter.dart';
import '../Response/CategoriesListResponse.dart';

class HomeController extends GetxController implements CategoriesListGetView {
  final PageController bannerController = PageController();

  final bannerImages = [
    "assets/real/banner1.png",
    "assets/real/banner2.jpg",
    "assets/real/banner3.jpg",
    "assets/real/banner5.jpg"
  ].obs;

  final categories = <Map<String, dynamic>>[
    {"icon": Icons.devices_other, "name": "electronics"},
    {"icon": Icons.diamond_outlined, "name": "jewelery"},
    {"icon": Icons.man, "name": "men's clothing"},
    {"icon": Icons.woman, "name": "women's clothing"},
  ].obs;

  var selectedCategory = 0.obs;

  // API Data
  var productList = <CategoriesListResponse>[].obs;
  var isLoading = false.obs;

  late CategoriesListPresenter presenter;

  @override
  void onInit() {
    super.onInit();
    presenter = CategoriesListPresenter(this);

    // Load first category by default
    getProducts(categories[0]["name"]);
  }

  void changeCategory(int index) {
    selectedCategory.value = index;
    getProducts(categories[index]["name"]);
  }

  void getProducts(String category) {
    presenter.getCategoriesListData(category);
  }

  @override
  void showCategoriesListDataGetResponse(List<CategoriesListResponse> response) {
    productList.value = response;
  }

  @override
  void showLoading() => isLoading.value = true;

  @override
  void hideLoading() => isLoading.value = false;

  @override
  void showError(String message) {}
}
