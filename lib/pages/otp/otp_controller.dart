import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/components/snackbar_component.dart';
import 'package:todo_app/routes/app_page.dart';

class OtpController extends GetxController {
  GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
  final focusNode = FocusNode();
  final verificationCode = TextEditingController();

  Future<void> onVerifyClick(String authToken) async {
    final credential = PhoneAuthProvider.credential(
        verificationId: authToken, smsCode: verificationCode.text.toString());

    print("verificationId: $authToken");
    print("verificationId: ${verificationCode.text.toString()}");

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);
      Get.offAllNamed(AppRoutes.homeScreen);
    } catch (e) {
      Get.back();
      SnackbarCompnent.showSnackbar('Failed', e.toString(), Colors.red);
    }
  }
}
