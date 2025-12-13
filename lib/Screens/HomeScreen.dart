import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Controller/HomeController.dart';
import '../Presenter/CategoriesListPresenter.dart';
import '../Response/CategoriesListResponse.dart';
import '../Views/MVPView.dart';
import 'ProductDetailsScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements CategoriesListGetView {
  final HomeController controller = Get.put(HomeController());
  late CategoriesListPresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = CategoriesListPresenter(this);

    // Load default category
    presenter.getCategoriesListData(controller.categories[0]["name"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _topBar(),
                _searchBar(),
                SizedBox(height: 15),
                _bannerSlider(),
                SizedBox(height: 15),
                _categoryList(),
                SizedBox(height: 20),
                _productGrid(),
              ],
            ),
          );
        }),
      ),
    );
  }

  // ---------------------- UI WIDGETS ---------------------- //

  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Icon(Icons.grid_view_rounded, size: 28),
          Icon(Icons.notifications_none_rounded, size: 30),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 45,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: const [
            Icon(Icons.search, color: Colors.grey),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search...",
                ),
              ),
            ),
            Icon(Icons.filter_list, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _bannerSlider() {
    return SizedBox(
      height: 160,
      child: PageView.builder(
        controller: controller.bannerController,
        itemCount: controller.bannerImages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                controller.bannerImages[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _categoryList() {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 16),
        itemCount: controller.categories.length,
        itemBuilder: (context, index) {
          bool isSelected = controller.selectedCategory.value == index;

          return GestureDetector(
            onTap: () {
              controller.changeCategory(index);
              presenter.getCategoriesListData(controller.categories[index]["name"]);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor:
                    isSelected ? Colors.orange.shade100 : Colors.grey.shade100,
                    child: Icon(
                      controller.categories[index]["icon"],
                      color: isSelected ? Colors.orange : Colors.grey,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    controller.categories[index]["name"],
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.orange : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _productGrid() {
    if (controller.isLoading.value) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.only(top: 40),
          child: CircularProgressIndicator(color: Colors.orange),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 40),
      itemCount: controller.productList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.70,
      ),
      itemBuilder: (context, index) {
        var item = controller.productList[index];

        return GestureDetector(
            onTap: () {
          Get.to(() => ProductDetailsScreen(item: item));
        },
        child: Stack(

        children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                    child: Image.network(
                      item.image ?? "",
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      item.title ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "\$${item.price}",
                      style: const TextStyle(
                        color: Colors.orange,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 8, top: 6, bottom: 8),
                    child: Row(
                      children: const [
                        CircleAvatar(radius: 5, backgroundColor: Colors.black),
                        SizedBox(width: 5),
                        CircleAvatar(radius: 5, backgroundColor: Colors.red),
                        SizedBox(width: 5),
                        CircleAvatar(radius: 5, backgroundColor: Colors.blue),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),

          ],
        ),
        );

      },
    );
  }

  // ---------------------- PRESENTER CALLBACKS ---------------------- //

  @override
  void showCategoriesListDataGetResponse(List<CategoriesListResponse> response) {
    controller.productList.assignAll(response);
  }

  @override
  void showLoading() {
    controller.isLoading.value = true;
  }

  @override
  void hideLoading() {
    controller.isLoading.value = false;
  }

  @override
  void showError(String msg) {
    // TODO: implement showError
  }
}
