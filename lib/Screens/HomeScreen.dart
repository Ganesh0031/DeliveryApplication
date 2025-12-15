
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/HomeController.dart';
import 'ProductDetailsScreen.dart';

class HomeScreen extends StatelessWidget {

  HomeScreen({super.key});

  final HomeController controller = Get.put(HomeController());

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
                const SizedBox(height: 15),
                _bannerSlider(),
                const SizedBox(height: 15),
                _categoryList(),
                const SizedBox(height: 20),
                _productGrid(),
              ],
            ),
          );
        }),
      ),
    );
  }


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
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.grey),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                onChanged: controller.searchProduct,
                decoration: const InputDecoration(
                  hintText: "Search products...",
                  border: InputBorder.none,
                ),
              ),
            ),
            const Icon(Icons.filter_list, color: Colors.grey),
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
        itemBuilder: (_, index) {
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
        itemBuilder: (_, index) {
          final isSelected = controller.selectedCategory.value == index;

          return GestureDetector(
            onTap: () => controller.changeCategory(index),
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
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    controller.categories[index]["name"],
                    style: TextStyle(
                      fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.normal,
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
      return const Padding(
        padding: EdgeInsets.only(top: 40),
        child: Center(
          child: CircularProgressIndicator(color: Colors.orange),
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 40),
      itemCount: controller.filteredProducts.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.70,
      ),
      itemBuilder: (_, index) {
        final item = controller.filteredProducts[index];

        // Sample color codes for the product (replace with your data)
        final colorOptions = [
          Colors.black,
          Colors.red,
          Colors.blue,
          Colors.orange,
        ];

        // Use RxBool for heart toggle
        final isFavorite = false.obs;

        return GestureDetector(
          onTap: () => Get.to(() => ProductDetailsScreen(item: item)),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
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

                    // Heart icon top-right with toggle
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Obx(() => InkWell(
                        onTap: () => isFavorite.value = !isFavorite.value,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            isFavorite.value
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 20,
                            color:
                            isFavorite.value ? Colors.orange : Colors.grey,
                          ),
                        ),
                      )),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    item.title ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      // Price
                      Text(
                        "\$${item.price}",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // Spacer pushes color circles to the right
                      const Spacer(),

                      // Color options
                      Row(
                        children: colorOptions.map((color) {
                          return Container(
                            margin: const EdgeInsets.only(left: 4),
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: color,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

}
