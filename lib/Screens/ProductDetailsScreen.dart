import 'package:currency_converter/Utils/Constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/ProductDetailsController.dart';
import '../Response/CategoriesListResponse.dart';

class ProductDetailsScreen extends StatefulWidget {
  final CategoriesListResponse item;

  const ProductDetailsScreen({super.key, required this.item});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late ProductDetailsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ProductDetailsController(widget.item));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// ================= BODY =================
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _topBar(),
              _productImage(),
              _titlePrice(),
              _ratingSeller(),
              _colorSection(),
              _tabs(),
              _description(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(child: _bottomBar()),
    );
  }

  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _iconCircle(Icons.arrow_back_ios_new, () => Get.back()),
          _iconCircle(Icons.favorite_border, () {}),
        ],
      ),
    );
  }

  Widget _productImage() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Center(
        child: Image.network(
          widget.item.image!,
          height: 200,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _titlePrice() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              widget.item.title!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            "\$${widget.item.price}",
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _ratingSeller() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Icon(Icons.star, size: 14, color: Colors.orange),
                const SizedBox(width: 4),
                Text(
                  widget.item.rating?.rate.toString() ?? "0.0",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Text(
            "(${widget.item.rating?.count} Reviews)",
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const Spacer(),
          const Text(
            "Seller: Syed Noman",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }


  Widget _colorSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Color",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Obx(
                () => Row(
              children: [
                _colorDot(Colors.black),
                _colorDot(const Color(0xfff4a261)),
                _colorDot(const Color(0xff2a9d8f)),
                _colorDot(const Color(0xff457b9d)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _colorDot(Color color) {
    return GestureDetector(
      onTap: () => controller.changeColor(color),
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: controller.selectedColor.value == color
                ? Colors.orange
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: CircleAvatar(radius: 9, backgroundColor: color),
      ),
    );
  }

  Widget _tabs() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
      child: Obx(
            () => Row(
          children: [
            _tab("Description", 0),
            const SizedBox(width: 24),
            _tab("Specifications", 1),
            const SizedBox(width: 24),
            _tab("Reviews", 2),
          ],
        ),
      ),
    );
  }

  Widget _tab(String title, int index) {
    final active = controller.selectedTab.value == index;
    return GestureDetector(
      onTap: () => controller.changeTab(index),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: active ? FontWeight.bold : FontWeight.normal,
              color: active ? Colors.orange : Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 3,
            width: 36,
            decoration: BoxDecoration(
              color: active ? Colors.orange : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }

  Widget _description() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 30),
      child: Text(
        widget.item.description ?? "",
        style: const TextStyle(
          fontSize: 13,
          height: 1.5,
          color: Colors.black87,
        ),
      ),
    );
  }


  Widget _bottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Obx(
            () => Row(
          children: [

            Container(
              height: 46,
              padding: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  _qtyBtn(Icons.remove, controller.decreaseQty),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      controller.quantity.value.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                  ),
                  _qtyBtn(Icons.add, controller.increaseQty),
                ],
              ),
            ),

            const SizedBox(width: 14),

            /// Add to Cart Button
            Expanded(
              child: GestureDetector(
                onTap: controller.addToCart,
                child: Container(
                  height: 46,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Text(
                      "Add to Cart",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  /// ================= COMMON WIDGETS =================
  Widget _qtyBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: 18,
          color: Colors.white,
        ),
      ),
    );
  }


  Widget _iconCircle(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 6),
          ],
        ),
        child: Icon(icon, size: 18),
      ),
    );
  }
}
