import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/components/loader.dart';
import 'package:todo_app/pages/signin/signin_controller.dart';
import 'package:todo_app/routes/app_page.dart';
import 'package:todo_app/theme/colors.dart';
import 'package:todo_app/theme/text_styles.dart';
import 'package:todo_app/utils/validation_mixin.dart';
import 'package:todo_app/widget/common/custom_button.dart';
import 'package:todo_app/widget/common/custom_textfield.dart';

class SigninScreen extends StatelessWidget with ValidationsMixin {
  SigninScreen({super.key});

  final signinController = Get.find<SigninController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: signinController.signinFormKey,
            child: Column(
              children: [
                //Header
                SizedBox(height: 66.h),
                Text(
                  'Login',
                  style: kTextStyleGabaritoBold.copyWith(
                    fontSize: 30.sp,
                  ),
                ),
                // Login form
                SizedBox(height: 12.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      // First Name
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'E-mail',
                              style: kTextStyleGabaritoRegular.copyWith(
                                fontSize: 14.sp,
                                color: kColorBlackNeutral800,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            CustomTextField(
                              controller: signinController.email,
                              hintText: 'Enter your email',
                              hintStyle: kTextStyleGabaritoRegular.copyWith(
                                fontSize: 14.sp,
                                color: kColorGreyNeutral400,
                              ),
                              radius: 8,
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
                ),
                SizedBox(height: 12.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Password',
                              style: kTextStyleGabaritoRegular.copyWith(
                                fontSize: 14.sp,
                                color: kColorBlackNeutral800,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Obx(
                              () => CustomTextField(
                                controller: signinController.password,
                                maxLines: 1,
                                isPassword: signinController.hidePassword.value,
                                hintText: 'Enter your password',
                                hintStyle: kTextStyleGabaritoRegular.copyWith(
                                  fontSize: 14.sp,
                                  color: kColorGreyNeutral400,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () =>
                                      signinController.hidePassword.value =
                                          !signinController.hidePassword.value,
                                  icon: Icon(
                                    signinController.hidePassword.value
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                  ),
                                ),
                                radius: 8,
                                style: kTextStyleGabaritoRegular.copyWith(
                                  fontSize: 14.sp,
                                  color: kColorGreyNeutral600,
                                ),
                                validator: validatePassword,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.forgotPasswordScreen,
                      arguments: "forgot_password"),
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20.w, top: 12.h),
                    child: Text(
                      'Forgot Password?',
                      style: kTextStyleGabaritoRegular.copyWith(
                        fontSize: 14.sp,
                        color: kColorBlueAccent,
                        decoration: TextDecoration.underline,
                        decorationColor: kColorBlueAccent,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: CustomButton(
                    color: kColorPrimary,
                    textColor: kColorWhite,
                    label: "Login",
                    press: () async {
                      await signinController.onLoginClicked();
                    },
                  ),
                ),
                SizedBox(height: 150.h),
                Container(
                  alignment: Alignment.center,
                  child: Text.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: "Don't have an account? ",
                        style: kTextStyleGabaritoRegular.copyWith(
                          fontSize: 14.sp,
                          color: kColorGreyNeutral400,
                        ),
                      ),
                      TextSpan(
                        text: "Signup",
                        recognizer: TapGestureRecognizer()
                          ..onTap =
                              () => Get.toNamed(AppRoutes.registrationScreen),
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
    );
  }
}
