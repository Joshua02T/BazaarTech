import 'package:bazaartech/core/const_data/font_family.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'app_colors.dart';

class FontStyles {
  static TextStyle fieldTitleStyle(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return TextStyle(
      color: AppColors.darkGrey,
      fontSize: screenWidth / 25.75,
    );
  }

  static TextStyle buttonTextStyle(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return TextStyle(
      fontSize: screenWidth / 20.6,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle havingAccTextStyle(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return TextStyle(
      color: AppColors.primaryFontColor,
      fontSize: screenWidth / 31.69,
    );
  }

  static TextStyle havingAccSignStyle(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return TextStyle(
      color: AppColors.primaryOrangeColor,
      fontFamily: FontFamily.russoOne,
      fontSize: screenWidth / 29.42,
    );
  }
}
