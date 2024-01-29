import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:todo_app/components/snackbar_component.dart';
import 'package:todo_app/pages/register/register_controller.dart';
import 'package:todo_app/routes/app_page.dart';

class EditProfileController extends GetxController {
  GlobalKey<FormState> editProfileFormKey = GlobalKey<FormState>();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final newEmail = TextEditingController();

  Future<void> onUpdateAccount() async {
    if (editProfileFormKey.currentState!.validate()) {
      if (RegisterController.pickedImageFile.value == null) {
        Get.back();
        SnackbarCompnent.showSnackbar(
            "Attention!", "Please set profile image", Colors.red);
      }

      try {
        // Store image
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user-images')
            .child('${FirebaseAuth.instance.currentUser!.uid}.jpg');

        await storageRef.putFile(RegisterController.pickedImageFile.value!);
        final imageURL = await storageRef.getDownloadURL();

        resetemail();
        // // Update email

        // Create firestore collection to store data

        await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update(
          {
            "first_name": firstName.text.toString(),
            "last_name": lastName.text.toString(),
            "email": newEmail.text.toString(),
            "image_url": imageURL,
          },
        );

        // Showing Snackbar of Successfully account is created
        SnackbarCompnent.showSnackbar(
            "Congratulation", "Account updated successfully", Colors.green);

        // Get.toNamed(AppRoutes.homeScreen);
        Get.offAllNamed(AppRoutes.homeScreen);
      } on FirebaseAuthException catch (error) {
        if (error.code == 'email-already-in-use') {}
        Get.back();
        SnackbarCompnent.showSnackbar(
            error.message ?? "Updation failed", "Please try again", Colors.red);
      }
    }
  }

  Future resetemail() async {
    var message;
    final firebaseuser = await FirebaseAuth.instance.currentUser;
    firebaseuser
        ?.updateEmail(newEmail.text.toString())
        .then(
          (value) => message = 'success',
        )
        .catchError((onerror) => message = 'error');
    return message;
  }
}
