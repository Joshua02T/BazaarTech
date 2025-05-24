import 'package:flutter/material.dart';

class AppColors {
  static const Color white = Color(0xffffffff);
  static const Color black = Color(0xff000000);
  static const Color black60 = Color.fromRGBO(0, 0, 0, 0.6);
  static const Color black70 = Color.fromRGBO(0, 0, 0, 0.7);
  static const Color obacity60black = Color(0xff666666);
  static const Color backgroundColor = Color(0xffF6F6F6);
  static const Color primaryOrangeColor = Color(0xffEE7330);
  static const Color secondaryOrangeColor = Color(0xffF5E6C5);
  static const Color lightOrangeColor = Color(0xffFAF3E1);
  static const Color primaryFontColor = Color(0xff222222);
  static const Color discountFontColor = Color.fromRGBO(34, 34, 34, 0.5);
  static const Color darkGrey = Color(0xff575757);
  static const Color red = Color.fromARGB(255, 255, 0, 0);
  static const Color slidableDeleteColor = Color(0xffD73A31);
  static const Color borderLightGrey = Color(0xffD9D9D9);
  static const Color lightGrey = Color(0xffECECEC);
  static const Color settingsLightOrange = Color.fromRGBO(238, 115, 48, 0.1);
}

class DarkAppColors {
  static const Color white = Color(0xffffffff); // Keep for contrast
  static const Color black = Color(0xff000000); // Background for dark theme
  static const Color backgroundColor = Color(0xff121212); // Dark background
  static const Color primaryOrangeColor =
      Color(0xffFB8C00); // Slightly lighter orange
  static const Color secondaryOrangeColor =
      Color(0xffFFE0B2); // Softer orange for highlights
  static const Color lightOrangeColor =
      Color(0xffFFF3E0); // Softer for elements
  static const Color primaryFontColor =
      Color(0xffE0E0E0); // Light grey for text
  static const Color darkGrey = Color(0xffBDBDBD); // Medium grey
  static const Color red = Color(0xffEF5350); // Muted red for dark backgrounds
  static const Color borderLightGrey = Color(0xff424242); // Dark border
  static const Color lightGrey = Color(0xff616161); // For dark surfaces
  static const Color settingsLightOrange =
      Color.fromRGBO(251, 140, 0, 0.1); // Subtle accent
}
