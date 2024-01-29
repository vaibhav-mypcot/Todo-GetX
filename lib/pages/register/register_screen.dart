import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/pages/register/register_controller.dart';
import 'package:todo_app/theme/colors.dart';
import 'package:todo_app/theme/text_styles.dart';
import 'package:todo_app/utils/validation_mixin.dart';
import 'package:todo_app/widget/common/custom_appbar.dart';
import 'package:todo_app/widget/common/custom_button.dart';
import 'package:todo_app/widget/common/custom_textfield.dart';
import 'package:todo_app/components/loader.dart';

class RegisterScreen extends StatelessWidget with ValidationsMixin {
  RegisterScreen({super.key});

  final registerController = Get.find<RegisterController>();

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppbar(
              press: () => Get.back(),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    Form(
                      key: registerController.registerFormKey,
                      child: Column(
                        children: [
                          // Herader
                          Text(
                            'Register',
                            style: kTextStyleGabaritoBold.copyWith(
                              fontSize: 30.sp,
                            ),
                          ),
                          SizedBox(height: 36.h),
                          // Uplaod profile image
                          Obx(() {
                            final pickedImageFile =
                                RegisterController.pickedImageFile.value;
                            return SizedBox(
                              height: 115,
                              width: 115,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  CircleAvatar(
                                    foregroundImage: pickedImageFile != null
                                        ? FileImage(pickedImageFile)
                                        : const AssetImage(
                                                "assets/images/profile_image.png")
                                            as ImageProvider,
                                  ),
                                  const Positioned(
                                    bottom: 0,
                                    right: -25,
                                    child: RawMaterialButton(
                                      onPressed: RegisterController
                                          .showOptionsBottomSheet,
                                      elevation: 2.0,
                                      fillColor: Color(0xFFF5F6F9),
                                      padding: EdgeInsets.all(8.0),
                                      shape: CircleBorder(),
                                      child: Icon(
                                        Icons.camera_alt_outlined,
                                        color: kColorPrimary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          SizedBox(height: 34.h),
                          // First NAme & Last Name
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // First Name
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'First Name',
                                        style:
                                            kTextStyleGabaritoRegular.copyWith(
                                          fontSize: 14.sp,
                                          color: kColorBlackNeutral800,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      CustomTextField(
                                        controller:
                                            registerController.firstName,
                                        hintText: 'Jhon',
                                        hintStyle:
                                            kTextStyleGabaritoRegular.copyWith(
                                          fontSize: 14.sp,
                                          color: kColorGreyNeutral400,
                                        ),
                                        radius: 8,
                                        style:
                                            kTextStyleGabaritoRegular.copyWith(
                                          fontSize: 14.sp,
                                          color: kColorGreyNeutral600,
                                        ),
                                        textInputType: TextInputType.name,
                                        validator: validatedName,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                // Last Name
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Last Name',
                                        style:
                                            kTextStyleGabaritoRegular.copyWith(
                                          fontSize: 14.sp,
                                          color: kColorBlackNeutral800,
                                        ),
                                      ),
                                      SizedBox(height: 6.h),
                                      CustomTextField(
                                        controller: registerController.lastName,
                                        hintText: 'Doe',
                                        hintStyle:
                                            kTextStyleGabaritoRegular.copyWith(
                                          fontSize: 14.sp,
                                          color: kColorGreyNeutral400,
                                        ),
                                        radius: 8,
                                        style:
                                            kTextStyleGabaritoRegular.copyWith(
                                          fontSize: 14.sp,
                                          color: kColorGreyNeutral600,
                                        ),
                                        textInputType: TextInputType.name,
                                        validator: validatedName,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // email address
                          SizedBox(height: 12.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'E-mail',
                                        style:
                                            kTextStyleGabaritoRegular.copyWith(
                                          fontSize: 14.sp,
                                          color: kColorBlackNeutral800,
                                        ),
                                      ),
                                      SizedBox(height: 6.h),
                                      CustomTextField(
                                        controller: registerController.email,
                                        hintText: 'Enter your email',
                                        hintStyle:
                                            kTextStyleGabaritoRegular.copyWith(
                                          fontSize: 14.sp,
                                          color: kColorGreyNeutral400,
                                        ),
                                        radius: 8,
                                        style:
                                            kTextStyleGabaritoRegular.copyWith(
                                          fontSize: 14.sp,
                                          color: kColorGreyNeutral600,
                                        ),
                                        textInputType:
                                            TextInputType.emailAddress,
                                        validator: validateEmail,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Password
                          SizedBox(height: 12.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Password',
                                        style:
                                            kTextStyleGabaritoRegular.copyWith(
                                          fontSize: 14.sp,
                                          color: kColorBlackNeutral800,
                                        ),
                                      ),
                                      SizedBox(height: 6.h),
                                      Obx(
                                        () => CustomTextField(
                                          controller:
                                              registerController.password,
                                          maxLines: 1,
                                          isPassword: registerController
                                              .hidePassword.value,
                                          hintText: '*********',
                                          hintStyle: kTextStyleGabaritoRegular
                                              .copyWith(
                                            fontSize: 14.sp,
                                            color: kColorGreyNeutral400,
                                          ),
                                          suffixIcon: IconButton(
                                            onPressed: () => registerController
                                                    .hidePassword.value =
                                                !registerController
                                                    .hidePassword.value,
                                            icon: Icon(
                                              registerController
                                                      .hidePassword.value
                                                  ? Icons.visibility_outlined
                                                  : Icons
                                                      .visibility_off_outlined,
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Password
                          SizedBox(height: 12.h),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 16.w,
                              right: 16.w,
                              bottom: 16.h,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Confirm Password',
                                        style:
                                            kTextStyleGabaritoRegular.copyWith(
                                          fontSize: 14.sp,
                                          color: kColorBlackNeutral800,
                                        ),
                                      ),
                                      SizedBox(height: 6.h),
                                      Obx(
                                        () => CustomTextField(
                                          controller: registerController
                                              .confirmPassword,
                                          maxLines: 1,
                                          isPassword: registerController
                                              .hideConfirmPassword.value,
                                          hintText: '*********',
                                          hintStyle: kTextStyleGabaritoRegular
                                              .copyWith(
                                            fontSize: 14.sp,
                                            color: kColorGreyNeutral400,
                                          ),
                                          suffixIcon: IconButton(
                                            onPressed: () => registerController
                                                    .hideConfirmPassword.value =
                                                !registerController
                                                    .hideConfirmPassword.value,
                                            icon: Icon(
                                              registerController
                                                      .hideConfirmPassword.value
                                                  ? Icons.visibility_outlined
                                                  : Icons
                                                      .visibility_off_outlined,
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
                          ),
                          // Submit Button
                          Container(
                            // margin: EdgeInsets.only(top: 14.h),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 16.w,
                                right: 16.w,
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: CustomButton(
                                  color: kColorPrimary,
                                  textColor: kColorWhite,
                                  label: "Create Account",
                                  press: () async {
                                    Utils.showLoader();
                                    await registerController.onCreateAccount();
                                    Get.back();
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
