import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {


  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  // Password visibility
  var obscurePassword = true.obs;

  // Login tap
  void login() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar("Error", "Please fill all fields",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // You can call API here
    print("Email: ${emailController.text}");
    print("Password: ${passwordController.text}");
  }
}
