import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/pages/forgot_password/forgot_password_controller.dart';
import 'package:todo_app/routes/app_page.dart';
import 'package:todo_app/theme/colors.dart';

class VerifyAccountController extends GetxController {
  GlobalKey<FormState> verifyAccountFormKey = GlobalKey<FormState>();

  final verifyEmail = TextEditingController();
  late String email = verifyEmail.text.toString();
  late int codeNumber = int.parse(email);

  int? code = ForgotPasswordController.getCode;

  void onVerifyClick() {
    if (verifyAccountFormKey.currentState!.validate() && code == codeNumber) {
      Get.snackbar(
        'Congratulation',
        'You enetred valid code',
        colorText: kColorPrimary,
      );
    } else {
      Get.snackbar(
        'Failed',
        'Please enter valid code',
        colorText: kColorPrimary,
      );
    }
    Get.toNamed(AppRoutes.createNewPasswordScreen);
  }
}
