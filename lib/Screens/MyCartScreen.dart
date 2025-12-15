import 'package:currency_converter/Screens/HomeScreen.dart';
import 'package:currency_converter/Screens/MyTabBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/CartController.dart';

class MyCartScreen extends StatelessWidget {
  final CartController controller = Get.find<CartController>();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {


              Get.offAll(MyTabBar());



          },
        ),
        title: const Text(
          "My Cart",
          style: TextStyle(
            height: 1.7,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: Obx(() {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: controller.cartList.length,
                itemBuilder: (context, index) {
                  var item = controller.cartList[index];

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          blurRadius: 6,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                /// Product Image
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    item.product.image ?? "",
                                    height: 55,
                                    width: 55,
                                    fit: BoxFit.cover,
                                  ),
                                ),

                                const SizedBox(width: 12),

                                /// Title + Price
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 24),
                                        child: Text(
                                          item.product.title ?? "",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "\$${item.product.price}",
                                        style: const TextStyle(
                                          color: Colors.orange,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                margin: const EdgeInsets.only(top: 8),
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    InkWell(
                                      onTap: () => controller.decreaseQty(index),
                                      child: const Icon(Icons.remove, size: 18),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      item.quantity.toString(),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    InkWell(
                                      onTap: () => controller.increaseQty(index),
                                      child: const Icon(Icons.add, size: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        /// Delete Icon - Top Right Corner
                        Positioned(
                          top: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () => controller.removeFromCart(index),
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.delete,
                                size: 16,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );


                },
              ),
            ),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  /// Coupon Row
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Enter Discount Code",
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            isDense: true,
                          ),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          // TODO: Apply coupon logic
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side: const BorderSide(color: Colors.orange),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "Apply",
                          style: TextStyle(color: Colors.orange, fontSize: 14),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  /// Subtotal
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Subtotal", style: TextStyle(fontSize: 14)),
                      Text(
                        "\$${controller.total.toStringAsFixed(2)}",
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  /// Total
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(
                        "\$${controller.total.toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  /// Checkout Button
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Checkout action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                      ),
                      child: const Text(
                        "Checkout",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            )


          ],
        );
      }),
    );
  }
}
