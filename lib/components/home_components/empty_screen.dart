import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:todo_app/const/const.dart';
import 'package:todo_app/theme/colors.dart';
import 'package:todo_app/theme/text_styles.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SvgPicture.asset(
            Const().emptyImg,
            fit: BoxFit.cover,
            height: 227.h,
          ),
          Text(
            'What do you want to do today?'.tr,
            style: kTextStyleGabaritoMedium.copyWith(
              fontSize: 21,
              color: kColorBlackNeutral800,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'Tap + to add your tasks'.tr,
            style: kTextStyleGabaritoRegular.copyWith(
              fontSize: 18,
              color: kColorGreyNeutral600,
            ),
          ),
        ],
      ),
    );
  }
}
