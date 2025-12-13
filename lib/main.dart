import 'package:currency_converter/Screens/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Controller/CartController.dart'; // Import GetX

void main() {
  Get.put(CartController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false, // removes debug banner
      title: 'Delivery App',
      home: SplashScreen(),
    );
  }
}
