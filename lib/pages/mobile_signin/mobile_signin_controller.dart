import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/components/loader.dart';
import 'package:todo_app/components/snackbar_component.dart';
import 'package:todo_app/routes/app_page.dart';

class MobileSigninController extends GetxController {
  GlobalKey<FormState> mobileFormkey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;

  final mobileNumber = TextEditingController();

  Future<void> onContinueClick() async {
    if (mobileFormkey.currentState!.validate()) {
      await auth.verifyPhoneNumber(
        phoneNumber: "+91${mobileNumber.text}",
        verificationCompleted: (_) {},
        verificationFailed: (error) {
          SnackbarCompnent.showSnackbar('Failed', error.toString(), Colors.red);
          Get.back();
        },
        codeSent: (String verificationId, int? token) {
          Get.toNamed(AppRoutes.otpScreen, arguments: verificationId);
        },
        codeAutoRetrievalTimeout: (error) {
          SnackbarCompnent.showSnackbar('Failed', error.toString(), Colors.red);
          Get.back();
        },
      );
      print("Successfully Validate");
    }
  }
}
