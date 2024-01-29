import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/routes/app_page.dart';
import 'package:todo_app/theme/colors.dart';
import 'package:todo_app/theme/text_styles.dart';

class Utils {
  static void showLoader() {
    Get.dialog(
      const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: kColorPrimary,
            ),
            SizedBox(height: 16),
            Text("Loading..."),
          ],
        ),
      ),
      barrierDismissible: false, // Prevent dismissing with a tap outside
    );
  }

  static void showAlert() {
    Get.dialog(
      AlertDialog(
        backgroundColor: kColorPrimaryLight,
        content: Padding(
          padding: EdgeInsets.fromLTRB(6.h, 6.w, 6.h, 0.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Confirm logout...!!!".tr,
                style: kTextStyleGabaritoRegular.copyWith(
                  fontSize: 16.sp,
                  color: kColorBlackNeutral800,
                ),
              ),
              Text(
                "Are you sure, you want to logout".tr,
                style: kTextStyleGabaritoRegular.copyWith(
                  fontSize: 12.sp,
                  color: kColorGreyNeutral500,
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kColorGreyNeutral400,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        )),
                    child: Text(
                      'No'.tr,
                      style: kTextStyleGabaritoRegular.copyWith(
                        fontSize: 14.sp,
                        color: kColorWhite,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      Utils.showLoader();
                      await FirebaseAuth.instance.signOut();
                      Get.offAllNamed(AppRoutes.welcomeScreen);
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        )),
                    child: Text(
                      'Yes'.tr,
                      style: kTextStyleGabaritoRegular.copyWith(
                        fontSize: 14.sp,
                        color: kColorWhite,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),

      barrierDismissible: false, // Prevent dismissing with a tap outside
    );
  }
}
