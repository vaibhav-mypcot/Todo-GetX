import 'package:flutter/material.dart';
import 'package:todo_app/theme/colors.dart';

class KAppbarTheme {
  KAppbarTheme._();

  static AppBarTheme lightAppbarTheme = AppBarTheme(
    color: kColorWhite,
  );

  static AppBarTheme darkAppbarTheme = AppBarTheme(
    color: Colors.black,
  );
}
