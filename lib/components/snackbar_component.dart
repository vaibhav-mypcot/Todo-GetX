import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarCompnent {
  static void showSnackbar(String title, String meaasge, Color textColor) {
    Get.snackbar(
      title,
      meaasge,
      snackPosition: SnackPosition.BOTTOM,
      colorText: textColor,
      backgroundColor: Colors.white,
    );
  }
}
