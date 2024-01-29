import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/const/const.dart';
import 'package:todo_app/pages/home/home_controller.dart';
import 'package:todo_app/routes/app_page.dart';
import 'package:todo_app/theme/colors.dart';
import 'package:todo_app/theme/text_styles.dart';
import 'package:todo_app/widget/common/custom_appbar.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    String first_name = controller.userData["first_name"];
    String name = controller.userData["last_name"];
    String email = controller.userData["email"];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppbar(
              press: () => Get.back(),
            ),
            SizedBox(height: 6.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profile'.tr,
                    style: kTextStyleGabaritoBold.copyWith(
                      fontSize: 30.sp,
                    ),
                  ),
                  SizedBox(height: 18.h),
                  Card(
                    color: kColorPrimary,
                    elevation: 8,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 18.w, vertical: 18.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 255, 255),
                                radius: 34.0,
                                child: CircleAvatar(
                                  radius: 32.0,
                                  backgroundImage: NetworkImage(
                                    controller.userData["image_url"] ??
                                        Image.asset(Const().profileImage),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 16.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    email.toString() ?? "example@gmail.com",
                                    style: kTextStyleGabaritoMedium.copyWith(
                                      fontSize: 16.sp,
                                      color: kColorWhite,
                                    ),
                                  ),
                                  Text(
                                    first_name.toString() ??
                                        "example@gmail.com",
                                    style: kTextStyleGabaritoRegular.copyWith(
                                      fontSize: 14.sp,
                                      color: kColorWhite,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 28.h),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Color.fromARGB(255, 242, 242, 242),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 18.w, vertical: 18.h),
                      child: Column(
                        children: [
                          // User account  //
                          GestureDetector(
                            onTap: () =>
                                Get.toNamed(AppRoutes.editProfileScreen),
                            child: Container(
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "My Account".tr,
                                            style: kTextStyleGabaritoMedium
                                                .copyWith(
                                              fontSize: 16.sp,
                                              color: kColorBlackNeutral800,
                                            ),
                                          ),
                                          Text(
                                            "Make changes to your account".tr,
                                            style: kTextStyleGabaritoRegular
                                                .copyWith(
                                              fontSize: 12.sp,
                                              color: kColorBlackNeutral800,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: kColorBlackNeutral800,
                                    size: 16.h,
                                  )
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 10.h),
                          const Divider(
                            height: 20,
                            color: kColorGreyNeutral200,
                          ),
                          SizedBox(height: 10.h),
                          // Change password
                          GestureDetector(
                            onTap: () =>
                                Get.toNamed(AppRoutes.forgotPasswordScreen),
                            child: Container(
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Change Password".tr,
                                            style: kTextStyleGabaritoMedium
                                                .copyWith(
                                              fontSize: 16.sp,
                                              color: kColorBlackNeutral800,
                                            ),
                                          ),
                                          Text(
                                            "Manage your password".tr,
                                            style: kTextStyleGabaritoRegular
                                                .copyWith(
                                              fontSize: 12.sp,
                                              color: kColorBlackNeutral800,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: kColorBlackNeutral800,
                                    size: 16.h,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
