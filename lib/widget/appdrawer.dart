import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/pages/home/home_controller.dart';
import 'package:todo_app/pages/signin/signin_controller.dart';
import 'package:todo_app/routes/app_page.dart';
import 'package:todo_app/storage/local_storage.dart';
import 'package:todo_app/theme/colors.dart';
import 'package:todo_app/theme/text_styles.dart';
import 'package:todo_app/components/loader.dart';

class AppDrawerWidget extends StatefulWidget {
  AppDrawerWidget({
    super.key,
    required this.onClearData,
  });

  // final String fName, lName, email;
  // final NetworkImage profileImage;
  final Function onClearData;

  @override
  State<AppDrawerWidget> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawerWidget> {
  bool isLanguageEnabled = false;
  // String selectedLanguage = 'English';
  List<String> languageOptions = ['Hindi'.tr, 'English'.tr];
  var isDark = false;

  final controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.zero,
            child: Container(
              color: kColorPrimary,
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(18.w, 56.h, 0.w, 10.h),
              child: Obx(() {
                String? firstLetter = controller.userData["first_name"];
                String? name = controller.userData["last_name"];
                String? email = controller.userData["email"];
                String? fullName;
                if (firstLetter != null || name != null) {
                  fullName = "$firstLetter $name";
                } else {
                  fullName = "Jhon Doe";
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 26.0,
                      backgroundImage: NetworkImage(
                        controller.userData["image_url"] ??
                            'https://www.nicepng.com/maxp/u2y3a9e6t4o0a9w7/',
                      ),
                    ),
                    SizedBox(height: 14),
                    Text(
                      fullName.toString(),
                      style: kTextStyleGabaritoMedium.copyWith(
                          fontSize: 18.sp, color: kColorWhite),
                    ),
                    Text(
                      email == null ? "jhon@gmail.com" : email.toString(),
                      style: kTextStyleGabaritoRegular.copyWith(
                          fontSize: 14.sp, color: kColorGreyNeutral200),
                    ) //circleAvata
                  ],
                );
              }),
            ),
          ),
          // SizedBox(
          //   height: 60,
          // ),
          ListTile(
            leading: Icon(Icons.language_sharp),
            title: Text('Translate'.tr),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  return DropdownButton<String>(
                    padding: EdgeInsets.zero,
                    underline: Container(),
                    value: controller.selectedLanguage.value,
                    items: languageOptions.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        controller.setLanguage(newValue!);

                        if (newValue == "Hindi") {
                          var locale = Locale('hi');
                          Get.updateLocale(locale);
                          lang.write('lang', 'hi');
                        } else if (newValue == "English") {
                          var locale = Locale('en');
                          Get.updateLocale(locale);
                          lang.write('lang', 'en');
                        }
                      });
                    },
                  );
                }),
              ],
            ),
            onTap: () {
              Get.back(); // Close the drawer
            },
          ),
          Obx(() {
            return ListTile(
              leading: Icon(Icons.dark_mode),
              title: Row(
                children: [
                  Text('Change Theme'.tr),
                  const Spacer(),
                  Switch(
                    value: controller.isDark.value,
                    onChanged: (state) {
                      controller.changeTheme(state);
                    },
                  ),
                ],
              ),
              onTap: () {
                Get.back(); // Close the drawer
              },
            );
          }),
          ListTile(
            leading: Icon(Icons.logout_outlined),
            title: Text('Logout'.tr),
            onTap: () async {
              Utils.showAlert();
              widget.onClearData();
            },
          ),
        ],
      ),
    );
  }
}
