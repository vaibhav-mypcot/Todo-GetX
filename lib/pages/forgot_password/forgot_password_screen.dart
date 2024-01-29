import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/components/loader.dart';
import 'package:todo_app/pages/forgot_password/forgot_password_controller.dart';
import 'package:todo_app/theme/colors.dart';
import 'package:todo_app/theme/text_styles.dart';
import 'package:todo_app/utils/validation_mixin.dart';
import 'package:todo_app/widget/common/custom_appbar.dart';
import 'package:todo_app/widget/common/custom_button.dart';
import 'package:todo_app/widget/common/custom_textfield.dart';

class ForgotPasswordScreen extends StatelessWidget with ValidationsMixin {
  ForgotPasswordScreen({super.key});

  final forgotPasswordController = Get.find<ForgotPasswordController>();

  final String? getPass = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppbar(press: () => Get.back()),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Form(
                    key: forgotPasswordController.forgotPasswordFormKey,
                    child: Column(
                      children: [
                        // Herader
                        Text(
                          'Forgot Password'.tr,
                          style: kTextStyleGabaritoBold.copyWith(
                            fontSize: 30.sp,
                            color: kColorBlackNeutral800,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          'No worries! Enter your email address below and we will send you a code to reset password.'.tr,
                          textAlign: TextAlign.center,
                          style: kTextStyleGabaritoRegular.copyWith(
                            fontSize: 14.sp,
                            color: kColorGreyNeutral600,
                          ),
                        ),
                        SizedBox(height: 32.h),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'E-mail'.tr,
                                    style: kTextStyleGabaritoRegular.copyWith(
                                      fontSize: 14.sp,
                                      color: kColorBlackNeutral800,
                                    ),
                                  ),
                                  SizedBox(height: 6.h),
                                  CustomTextField(
                                    controller:
                                        ForgotPasswordController.verifyEmail,
                                    hintText: 'Enter your email'.tr,
                                    hintStyle:
                                        kTextStyleGabaritoRegular.copyWith(
                                      fontSize: 14.sp,
                                      color: kColorGreyNeutral400,
                                    ),
                                    radius: 8.r,
                                    style: kTextStyleGabaritoRegular.copyWith(
                                      fontSize: 14.sp,
                                      color: kColorGreyNeutral600,
                                    ),
                                    textInputType: TextInputType.emailAddress,
                                    validator: validateEmail,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Submit Button
            Container(
              margin: EdgeInsets.only(top: 80.h),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomButton(
                  color: kColorPrimary,
                  textColor: kColorWhite,
                  label: "Send Reset Instruction".tr,
                  press: () async {
                    if (getPass == "forgot_password") {
                      Utils.showLoader();
                      forgotPasswordController.onResetPassword();
                      Get.back();
                    } else {
                      // Utils.showLoader();
                      forgotPasswordController.onUpdatePasswordClick();
                      // Get.back();
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}
