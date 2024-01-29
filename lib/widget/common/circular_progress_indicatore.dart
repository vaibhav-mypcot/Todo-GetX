import 'package:flutter/material.dart';
import 'package:todo_app/theme/colors.dart';

class CircularProgressIndicatorWidget extends StatelessWidget {
  const CircularProgressIndicatorWidget({super.key});



  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: kColorPrimary),
    );
  }
}
