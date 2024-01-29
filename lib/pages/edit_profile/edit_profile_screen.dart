import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/components/loader.dart';
import 'package:todo_app/pages/edit_profile/edit_profile_controller.dart';
import 'package:todo_app/pages/home/home_controller.dart';
import 'package:todo_app/pages/register/register_controller.dart';
import 'package:todo_app/theme/colors.dart';
import 'package:todo_app/theme/text_styles.dart';
import 'package:todo_app/utils/validation_mixin.dart';
import 'package:todo_app/widget/common/custom_appbar.dart';
import 'package:todo_app/widget/common/custom_button.dart';
import 'package:todo_app/widget/common/custom_textfield.dart';

class EditProfileScreen extends StatelessWidget with ValidationsMixin {
  EditProfileScreen({super.key});

  final editProfileController = Get.find<EditProfileController>();
  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    String first_name = controller.userData["first_name"];
    String last_name = controller.userData["last_name"];
    String email = controller.userData["email"];

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
                child: Column(
                  children: [
                    Form(
                      key: editProfileController.editProfileFormKey,
                      child: Column(
                        children: [
                          SizedBox(height: 16.h),
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
                                        : NetworkImage(
                                            controller.userData["image_url"],
                                          ) as ImageProvider,
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: -25,
                                    child: RawMaterialButton(
                                      onPressed: () => RegisterController
                                          .showOptionsBottomSheet(),
                                      elevation: 2.0,
                                      fillColor: Color(0xFFF5F6F9),
                                      padding: EdgeInsets.all(8.0),
                                      shape: CircleBorder(),
                                      child: const Icon(
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
                                        'First Name'.tr,
                                        style:
                                            kTextStyleGabaritoRegular.copyWith(
                                          fontSize: 14.sp,
                                          color: kColorBlackNeutral800,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      CustomTextField(
                                        controller:
                                            editProfileController.firstName,
                                        hintText: first_name.toString(),
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
                                        'Last Name'.tr,
                                        style:
                                            kTextStyleGabaritoRegular.copyWith(
                                          fontSize: 14.sp,
                                          color: kColorBlackNeutral800,
                                        ),
                                      ),
                                      SizedBox(height: 6.h),
                                      CustomTextField(
                                        controller:
                                            editProfileController.lastName,
                                        hintText: last_name.toString(),
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Submit Button
            Container(
              // margin: EdgeInsets.only(top: 14.h),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomButton(
                    color: kColorPrimary,
                    textColor: kColorWhite,
                    label: "Update Account".tr,
                    press: () async {
                      Utils.showLoader();
                      await editProfileController.onUpdateAccount();
                      Get.back();
                    }),
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
