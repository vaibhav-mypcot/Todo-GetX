import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/components/loader.dart';
import 'package:todo_app/routes/app_page.dart';

class SigninController extends GetxService {
  GlobalKey<FormState> signinFormKey = GlobalKey<FormState>();

  final hidePassword = true.obs;

  final email = TextEditingController();
  final password = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> onLoginClicked() async {
    Utils.showLoader();
    if (signinFormKey.currentState!.validate()) {
      try {
        final userCredential = await auth.signInWithEmailAndPassword(
          email: email.text.toString(),
          password: password.text.toString(),
        );
        Get.back();
        Get.offAllNamed(AppRoutes.homeScreen);
      } on FirebaseAuthException catch (error) {
        print("email is wrong");
        Get.back();
        if (error.code == 'email-already-in-use') {}
        Get.snackbar(
          error.message.toString() ?? "Registration failed",
          "Please try again",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.red,
          backgroundColor: Colors.white,
        );
      }
    }
  }

  void onClearData() {
    email.clear();
    password.clear();
  }
}
