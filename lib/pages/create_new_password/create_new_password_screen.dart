import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/pages/create_new_password/create_new_password_controller.dart';
import 'package:todo_app/theme/colors.dart';
import 'package:todo_app/theme/text_styles.dart';
import 'package:todo_app/utils/validation_mixin.dart';
import 'package:todo_app/widget/common/custom_appbar.dart';
import 'package:todo_app/widget/common/custom_button.dart';
import 'package:todo_app/widget/common/custom_textfield.dart';
import 'package:todo_app/components/loader.dart';

class CreateNewPasswordScreen extends StatelessWidget with ValidationsMixin {
  CreateNewPasswordScreen({super.key});

  final createNewPasswordController = Get.find<CreateNewPasswordController>();

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
                  child: Column(
                    children: [
                      // Herader
                      Text(
                        'Create New Password',
                        style: kTextStyleGabaritoBold.copyWith(
                          fontSize: 30.sp,
                          color: kColorBlackNeutral800,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'Please enter and confirm your new password.',
                        textAlign: TextAlign.center,
                        style: kTextStyleGabaritoRegular.copyWith(
                          fontSize: 14.sp,
                          color: kColorGreyNeutral600,
                        ),
                      ),
                      Text(
                        'You will need to login after you reset.',
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
                            child: Form(
                              key: createNewPasswordController
                                  .newPasswordFormKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Password

                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Password',
                                              style: kTextStyleGabaritoRegular
                                                  .copyWith(
                                                fontSize: 14.sp,
                                                color: kColorBlackNeutral800,
                                              ),
                                            ),
                                            SizedBox(height: 6.h),
                                            Obx(
                                              () => CustomTextField(
                                                controller:
                                                    createNewPasswordController
                                                        .newPassword,
                                                maxLines: 1,
                                                isPassword:
                                                    createNewPasswordController
                                                        .hidePassword.value,
                                                hintText: '*********',
                                                hintStyle:
                                                    kTextStyleGabaritoRegular
                                                        .copyWith(
                                                  fontSize: 14.sp,
                                                  color: kColorGreyNeutral400,
                                                ),
                                                suffixIcon: IconButton(
                                                  onPressed: () =>
                                                      createNewPasswordController
                                                              .hidePassword
                                                              .value =
                                                          !createNewPasswordController
                                                              .hidePassword
                                                              .value,
                                                  icon: Icon(
                                                    createNewPasswordController
                                                            .hidePassword.value
                                                        ? Icons
                                                            .visibility_off_outlined
                                                        : Icons
                                                            .visibility_outlined,
                                                  ),
                                                ),
                                                radius: 8,
                                                style: kTextStyleGabaritoRegular
                                                    .copyWith(
                                                  fontSize: 14.sp,
                                                  color: kColorGreyNeutral600,
                                                ),
                                                validator: validatePassword,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, top: 6),
                                              child: Text(
                                                'must contain 8 characters',
                                                style: kTextStyleGabaritoRegular
                                                    .copyWith(
                                                  fontSize: 14.sp,
                                                  color: kColorGreyNeutral500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Password
                                  SizedBox(height: 12.h),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Confirm Password',
                                              style: kTextStyleGabaritoRegular
                                                  .copyWith(
                                                fontSize: 14.sp,
                                                color: kColorBlackNeutral800,
                                              ),
                                            ),
                                            SizedBox(height: 6.h),
                                            Obx(
                                              () => CustomTextField(
                                                controller:
                                                    createNewPasswordController
                                                        .confirmPassword,
                                                maxLines: 1,
                                                isPassword:
                                                    createNewPasswordController
                                                        .hideConfirmPassword
                                                        .value,
                                                hintText: '*********',
                                                hintStyle:
                                                    kTextStyleGabaritoRegular
                                                        .copyWith(
                                                  fontSize: 14.sp,
                                                  color: kColorGreyNeutral400,
                                                ),
                                                suffixIcon: IconButton(
                                                  onPressed: () =>
                                                      createNewPasswordController
                                                              .hideConfirmPassword
                                                              .value =
                                                          !createNewPasswordController
                                                              .hideConfirmPassword
                                                              .value,
                                                  icon: Icon(
                                                    createNewPasswordController
                                                            .hideConfirmPassword
                                                            .value
                                                        ? Icons
                                                            .visibility_off_outlined
                                                        : Icons
                                                            .visibility_outlined,
                                                  ),
                                                ),
                                                radius: 8,
                                                style: kTextStyleGabaritoRegular
                                                    .copyWith(
                                                  fontSize: 14.sp,
                                                  color: kColorGreyNeutral600,
                                                ),
                                                validator: matchPasswords,
                                              ),
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
                        ],
                      ),
                    ],
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
                  label: "Send Reset Instruction",
                  press: () async {
                    // Utils.showLoader();
                    createNewPasswordController.onResetPasswordClick();
                    // Get.back();
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
