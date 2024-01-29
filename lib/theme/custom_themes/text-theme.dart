import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/theme/colors.dart';
import 'package:todo_app/theme/text_styles.dart';

class KTextTheme {
  //private constructor
  KTextTheme._();

  static TextTheme lightTextTheme = TextTheme(
      headlineLarge: kTextStyleGabaritoBold.copyWith(
        fontSize: 22.sp,
        color: kColorBlackNeutral800,
      ),
      headlineMedium: kTextStyleGabaritoMedium.copyWith(
        fontSize: 18.sp,
        color: kColorBlackNeutral800,
      ),
      headlineSmall: kTextStyleGabaritoRegular.copyWith(
        fontSize: 16.sp,
        color: kColorBlackNeutral800,
      ));
  static TextTheme darkTextTheme = TextTheme(
      headlineLarge: kTextStyleGabaritoBold.copyWith(
        fontSize: 22.sp,
        color: kColorWhite,
      ),
      headlineMedium: kTextStyleGabaritoMedium.copyWith(
        fontSize: 18.sp,
        color: kColorWhite,
      ),
      headlineSmall: kTextStyleGabaritoRegular.copyWith(
        fontSize: 16.sp,
        color: kColorWhite,
      ));
}
