import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/components/loader.dart';
import 'package:todo_app/pages/otp/otp_controller.dart';
import 'package:todo_app/theme/colors.dart';
import 'package:todo_app/theme/text_styles.dart';
import 'package:todo_app/widget/common/custom_appbar.dart';
import 'package:todo_app/widget/pinput_widget.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  String verificationId = Get.arguments;
  final otpController = Get.find<OtpController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          CustomAppbar(
            press: () => Get.back(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Column(
              children: [
                SizedBox(height: 128.h),
                Text(
                  "Enter 4 digits verification code sent to your number",
                  textAlign: TextAlign.center,
                  style: kTextStyleGabaritoMedium.copyWith(
                    fontSize: 18.sp,
                    color: kColorBlackNeutral800,
                  ),
                ),
                SizedBox(height: 68.h),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: PinPutWidget(
                    otpFormKey: otpController.otpFormKey,
                    focusNode: otpController.focusNode,
                    pinController: otpController.verificationCode,
                    onVerifyClick: () {
                      Utils.showLoader();
                      otpController.onVerifyClick(verificationId);
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
