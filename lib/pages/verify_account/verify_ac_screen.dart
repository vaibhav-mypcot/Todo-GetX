import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/pages/verify_account/verify_ac_controller.dart';
import 'package:todo_app/theme/colors.dart';
import 'package:todo_app/theme/text_styles.dart';
import 'package:todo_app/utils/validation_mixin.dart';
import 'package:todo_app/widget/common/custom_appbar.dart';
import 'package:todo_app/widget/common/custom_button.dart';
import 'package:todo_app/widget/common/custom_textfield.dart';
import 'package:todo_app/components/loader.dart';

class VerifyAccountScreen extends StatelessWidget with ValidationsMixin {
  VerifyAccountScreen({super.key});

  final verifyAccountController = Get.find<VerifyAccountController>();
  String? emailText = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: verifyAccountController.verifyAccountFormKey,
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
                          'Verify Account',
                          style: kTextStyleGabaritoBold.copyWith(
                            fontSize: 30.sp,
                            color: kColorBlackNeutral800,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          'Code has been send to $emailText',
                          textAlign: TextAlign.center,
                          style: kTextStyleGabaritoRegular.copyWith(
                            fontSize: 14.sp,
                            color: kColorGreyNeutral600,
                          ),
                        ),
                        Text(
                          'Enter the code to verify your account.',
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
                                    'Enter Code',
                                    style: kTextStyleGabaritoRegular.copyWith(
                                      fontSize: 14.sp,
                                      color: kColorBlackNeutral800,
                                    ),
                                  ),
                                  SizedBox(height: 6.h),
                                  CustomTextField(
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(4),
                                    ],
                                    controller:
                                        verifyAccountController.verifyEmail,
                                    hintText: '4 Digit Code',
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
                                    textInputType: TextInputType.number,
                                    validator: validateOTPCode,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 150.h),
                        Container(
                          alignment: Alignment.center,
                          child: Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                text: "Didn't Receive Code? ",
                                style: kTextStyleGabaritoRegular.copyWith(
                                  fontSize: 14.sp,
                                  color: kColorGreyNeutral400,
                                ),
                              ),
                              TextSpan(
                                text: "Resend Code",
                                // recognizer: TapGestureRecognizer()
                                //   ..onTap = () => Get.toNamed(
                                //       AppRoutes.registrationScreen),
                                style: kTextStyleGabaritoRegular.copyWith(
                                  fontSize: 14.sp,
                                  color: kColorBlueAccent,
                                  decoration: TextDecoration.underline,
                                  decorationColor: kColorBlueAccent,
                                ),
                              )
                            ]),
                          ),
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
                    label: "Verify Account",
                    press: () async {
                      // Utils.showLoader();
                      verifyAccountController.onVerifyClick();
                      // Get.back();
                    }, color: kColorPrimary, textColor: kColorWhite,
                  ),
                ),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
