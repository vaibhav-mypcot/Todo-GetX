import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/components/snackbar_component.dart';
import 'package:todo_app/routes/app_page.dart';
import 'package:todo_app/theme/colors.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordController extends GetxController {
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();
  static int? getCode;

  static final verifyEmail = TextEditingController();

  // Reset password

  void onResetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: verifyEmail.text.toString())
          .then((value) => {
                SnackbarCompnent.showSnackbar(
                    "Congratulation", "Email Sent", Colors.green),
                Get.offAllNamed(AppRoutes.signinScreen),
              });
    } catch (error) {
      SnackbarCompnent.showSnackbar("Smothing wen wrong", "$error", Colors.red);
    }
  }

  // Update password
  void onUpdatePasswordClick() async {
    if (forgotPasswordFormKey.currentState!.validate()) {
      Get.snackbar(
        'Congratulation',
        'You enetred valid email',
        colorText: kColorPrimary,
      );
    }

    sendEmail();
    print("this is your email address: ${verifyEmail.text.toString()}");
    Get.toNamed(AppRoutes.verifyAccountScreen);
  }

  Future sendEmail() async {
    final service_id = 'service_gipelb9';
    final template_id = 'template_2d6f8fp ';
    final user_id = '1exKCxE_cyox_M_1S';

    Random random = Random();
    int code = 1000 + random.nextInt(9000);
    getCode = code;

    try {
      final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
      final response = await http.post(url,
          headers: {
            'origin': 'http://localhost',
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'service_id': service_id,
            'template_id': 'template_2d6f8fp',
            'user_id': user_id,
            'template_params': {
              "user_subject": "reset password",
              "user_message": ''' We received a request to reset your password. 
              \nYour verification code is: $code 
              \nIf you didn't request a password reset, please ignore this email.
              \n
               ''',
              "user_name": "UpToDo Team",
              "user_email": verifyEmail.text.toString(),
              "to_email": verifyEmail.text.toString(),
            }
          }));
      print(response.body);
    } catch (e) {
      print("Smothing went wrong, failed to send email");
    }
  }
}
