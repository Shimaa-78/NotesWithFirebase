import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ThemeController extends GetxController {
  // RxBool to store the theme state (true for dark, false for light)
  var isDarkMode = false.obs;

  // Toggle theme method
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    // Change the system theme based on isDarkMode
    if (isDarkMode.value) {
      Get.changeTheme(ThemeData.dark()); // Set to dark theme
    } else {
      Get.changeTheme(ThemeData.light()); // Set to light theme
    }
  }
}
