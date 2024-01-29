import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:todo_app/components/loader.dart';
import 'package:todo_app/const/const.dart';
import 'package:todo_app/pages/mobile_signin/mobile_signin_controller.dart';
import 'package:todo_app/theme/colors.dart';
import 'package:todo_app/theme/text_styles.dart';
import 'package:todo_app/utils/validation_mixin.dart';
import 'package:todo_app/widget/common/custom_button.dart';
import 'package:todo_app/widget/common/custom_textfield.dart';

class MobileSigninScreen extends StatelessWidget with ValidationsMixin {
  MobileSigninScreen({super.key});

  final mobileSigninController = Get.find<MobileSigninController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 100.h),
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Form(
            key: mobileSigninController.mobileFormkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SvgPicture.asset(
                    Const().mobileNumberBanner,
                    fit: BoxFit.cover,
                    height: 168.h,
                  ),
                ),
                SizedBox(height: 44.h),
                Text(
                  'Enter your mobile number',
                  style: kTextStyleGabaritoMedium.copyWith(
                    fontSize: 18.sp,
                    color: kColorBlackNeutral800,
                  ),
                ),
                SizedBox(height: 14.h),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 6.h),
                          CustomTextField(
                            controller: mobileSigninController.mobileNumber,
                            maxLines: 1,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                            ],
                            textInputType: TextInputType.number,
                            prefixIcon: Container(
                              padding: EdgeInsets.only(top: 10.h),
                              child: Text(
                                '+91',
                                textAlign: TextAlign.center,
                                style: kTextStyleGabaritoRegular.copyWith(
                                  fontSize: 14.sp,
                                  color: kColorGreyNeutral600,
                                ),
                              ),
                            ),
                            hintText: 'Mobile Number',
                            hintStyle: kTextStyleGabaritoRegular.copyWith(
                              fontSize: 14.sp,
                              color: kColorGreyNeutral400,
                            ),
                            radius: 8,
                            style: kTextStyleGabaritoRegular.copyWith(
                              fontSize: 14.sp,
                              color: kColorGreyNeutral600,
                            ),
                            validator: validPhoneNumber,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.h),
                  child: CustomButton(
                    label: 'Continue',
                    press: () async {
                      Utils.showLoader();
                      await mobileSigninController.onContinueClick();
                      Get.back();
                    },
                    color: kColorPrimary,
                    textColor: kColorWhite,
                    borderColor: kColorPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
