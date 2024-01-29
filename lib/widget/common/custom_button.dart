import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/theme/colors.dart';
import 'package:todo_app/theme/text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.label,
    required this.press,
    required this.color,
    required this.textColor,
    this.borderColor,
  });

  final String label;
  final VoidCallback press;
  final Color color, textColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        height: 44.h,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(46.r),
            border: Border.all(
              color: borderColor ?? kColorWhite,
              width: 2,
            )),
        child: Text(
          label,
          style: kTextStyleGabaritoMedium.copyWith(
            fontSize: 14.sp,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
