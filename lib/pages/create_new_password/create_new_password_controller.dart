import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/pages/forgot_password/forgot_password_controller.dart';
import 'package:todo_app/routes/app_page.dart';
import 'package:todo_app/theme/colors.dart';

class CreateNewPasswordController extends GetxController {
  GlobalKey<FormState> newPasswordFormKey = GlobalKey<FormState>();

  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();

  final email = ForgotPasswordController.verifyEmail;

  final hidePassword = true.obs;
  final hideConfirmPassword = true.obs;

  void onResetPasswordClick() {
    if (newPasswordFormKey.currentState!.validate()) {
      Get.snackbar(
        'Congratulation',
        'You enetred valid otp',
        colorText: kColorPrimary,
      );
    }
    chnagePassword(ForgotPasswordController.verifyEmail.text.toString());
  }

  void chnagePassword(String enteredEmail) async {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    String? storedPassword;
    final userId;

    try {
      // Query the users collection to get the document with the entered email
      QuerySnapshot querySnapshot =
          await usersCollection.where('email', isEqualTo: enteredEmail).get();

      // Check if a document with the entered email exists
      if (querySnapshot.docs.isNotEmpty) {
        // Extract the first document (assuming email is unique) and get the password
        storedPassword = querySnapshot.docs.first.get('password');
        userId = querySnapshot.docs.first.get('unique_id');

        print("your password is: $storedPassword");
        print('User id : $userId');
      } else {
        //
        print("No user found with the entered email");
      }

      // Here we are updating the password by getting the email and password from the database
      final currentUser = FirebaseAuth.instance.currentUser;
      var cred = EmailAuthProvider.credential(
          email: enteredEmail, password: storedPassword!);

      await currentUser!.reauthenticateWithCredential(cred).then((value) {
        currentUser.updatePassword(confirmPassword.text.toString());
      }).catchError((onError) {
        print(onError.toString());
      });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .update(
        {
          "password": confirmPassword.text.toString(),
          "confirm_password": confirmPassword.text.toString(),
        },
      );

      Get.snackbar(
        'Congratulation',
        'Your password is successfully updated',
        colorText: kColorPrimary,
      );

      Get.offAllNamed(AppRoutes.signinScreen);
    } catch (e) {
      print('Error authenticating user: $e');
    }

    print("This is your email: ${enteredEmail} ");
    print("This is your password: ${storedPassword} ");
  }
}
