import 'package:flutter/material.dart';
import 'package:todo_app/theme/colors.dart';
import 'package:todo_app/theme/custom_themes/appbar-theme.dart';
import 'package:todo_app/theme/custom_themes/icons-theme.dart';
import 'package:todo_app/theme/custom_themes/text-theme.dart';

class KAppTheme {
  KAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: kColorPrimary,
    scaffoldBackgroundColor: kColorWhite,
    textTheme: KTextTheme.lightTextTheme,
    appBarTheme: KAppbarTheme.lightAppbarTheme,
    primaryIconTheme: KIconsTheme.lightIconTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: kColorPrimary,
    scaffoldBackgroundColor: Colors.black,
    textTheme: KTextTheme.darkTextTheme,
    appBarTheme: KAppbarTheme.darkAppbarTheme,
    primaryIconTheme: KIconsTheme.darkIconTheme,
  );
}
