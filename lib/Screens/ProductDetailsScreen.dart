
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/CartController.dart';
import '../Controller/ProductDetailsController.dart';
import '../Response/CategoriesListResponse.dart';

class ProductDetailsScreen extends StatefulWidget {
  final CategoriesListResponse item;

  const ProductDetailsScreen({super.key, required this.item});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late ProductDetailsController detailsController;

  @override
  void initState() {
    super.initState();
    // Initialize controller in initState
    detailsController = Get.put(ProductDetailsController(widget.item));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ---------- TOP BAR WITH BACK & HEART ----------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// BACK BUTTON
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: _headerIcon(Icons.arrow_back_ios_rounded),
                    ),

                    /// FAVORITE BUTTON
                    _headerIcon(
                      Icons.favorite_border,
                      iconColor: Colors.orange,
                    ),
                  ],
                ),
              ),

              /// ---------- PRODUCT IMAGE ----------
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    widget.item.image!,
                    height: 250,
                    width: 250,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              /// ---------- TITLE & PRICE ----------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.item.title!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      "\$${widget.item.price}",
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 5),

              /// ---------- RATING + SELLER ----------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.star,
                              size: 16, color: Colors.orange),
                          const SizedBox(width: 5),
                          Text(
                            widget.item.rating?.rate.toString() ?? "0.0",
                            style: TextStyle(
                                color: Colors.orange.shade900,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            " (${widget.item.rating?.count} Reviews)",
                            style: const TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      "Seller: Syed Noman",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// ---------- COLOR OPTIONS ----------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Color",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Row(
                      children: const [
                        CircleAvatar(radius: 10, backgroundColor: Colors.black),
                        SizedBox(width: 12),
                        CircleAvatar(radius: 10, backgroundColor: Colors.red),
                        SizedBox(width: 12),
                        CircleAvatar(radius: 10, backgroundColor: Colors.blue),
                        SizedBox(width: 12),
                        CircleAvatar(radius: 10, backgroundColor: Colors.teal),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// ---------- TABS (Description / Specs / Reviews) ----------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _tabButton("Description", 0),
                    _tabButton("Specifications", 1),
                    _tabButton("Reviews", 2),
                  ],
                )),
              ),

              const SizedBox(height: 15),

              /// ---------- TAB CONTENT ----------
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  widget.item.description ?? "",
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),

              const SizedBox(height: 100), // for button spacing
            ],
          ),
        ),
      ),

      /// ---------- ADD TO CART BUTTON ----------
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black12,
              offset: Offset(0, -2),
            )
          ],
        ),
        child: Obx(() => Row(
          children: [
            /// ---------- QUANTITY SELECTOR ----------
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  /// --- DECREASE BUTTON ---
                  GestureDetector(
                    onTap: () => detailsController.decreaseQty(),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: const Icon(Icons.remove, size: 20),
                    ),
                  ),

                  /// --- QUANTITY DISPLAY ---
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    child: Text(
                      detailsController.quantity.value.toString(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),

                  /// --- INCREASE BUTTON ---
                  GestureDetector(
                    onTap: () => detailsController.increaseQty(),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: const Icon(Icons.add, size: 20),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            /// ---------- ADD TO CART BUTTON ----------
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (detailsController.quantity.value > 0) {
                    detailsController.addToCart();

                    Get.snackbar(
                      "Added to Cart",
                      "${widget.item.title} (${detailsController.quantity.value}) added successfully!",
                      colorText: Colors.white,
                      backgroundColor: Colors.orange,
                      snackPosition: SnackPosition.BOTTOM,
                      duration: const Duration(seconds: 2),
                    );
                  } else {
                    Get.snackbar(
                      "Invalid Quantity",
                      "Please select at least 1 item",
                      colorText: Colors.white,
                      backgroundColor: Colors.red,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      "Add to Cart",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  /// TAB BUTTON WIDGET
  Widget _tabButton(String title, int index) {
    bool active = detailsController.selectedTab.value == index;

    return GestureDetector(
      onTap: () => detailsController.changeTab(index),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: active ? FontWeight.bold : FontWeight.normal,
              color: active ? Colors.orange : Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 4,
            width: 40,
            decoration: BoxDecoration(
              color: active ? Colors.orange : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _headerIcon(
    IconData icon, {
      Color iconColor = Colors.black,
    }) {
  return Container(
    height: 42,
    width: 42,
    decoration: BoxDecoration(
      color: Colors.white,
      shape: BoxShape.circle,
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 6,
          offset: Offset(0, 2),
        )
      ],
    ),
    child: Icon(icon, size: 20, color: iconColor),
  );
}