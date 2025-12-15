import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {


  var emailController = TextEditingController();
  var passwordController = TextEditingController();


  var obscurePassword = true.obs;

  void login() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar("Error", "Please fill all fields",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    print("Email: ${emailController.text}");
    print("Password: ${passwordController.text}");
  }
}
