import 'package:flutter/material.dart';

class AppStyles {
  static EdgeInsetsGeometry get screenPadding => const EdgeInsets.all(16.0);

  static double screenHeightPercentage(
      BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * percentage;
  }

  static double screenWidthPercentage(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * percentage;
  }

  static TextStyle get titleTextStyle => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Color.fromRGBO(20, 28, 36, 1),
      );

  static TextStyle get bodyTextStyle => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Color.fromRGBO(52, 64, 81, 1),
      );

  static TextStyle get hintTextStyle => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Color(0xFFCED2DA),
      );
}
