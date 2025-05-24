import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:flutter/material.dart';

class CustomProductCategory extends StatelessWidget {
  final String title;
  final bool isSelected;
  const CustomProductCategory(
      {super.key, required this.title, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: MediaQueryUtil.screenWidth / 25.75),
      padding: EdgeInsets.symmetric(
          horizontal: MediaQueryUtil.screenWidth / 25.75,
          vertical: MediaQueryUtil.screenHeight / 105.5),
      decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryOrangeColor
              : AppColors.backgroundColor,
          borderRadius:
              BorderRadius.circular(MediaQueryUtil.screenWidth / 51.5)),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              fontSize: MediaQueryUtil.screenWidth / 25.75,
              color: isSelected ? AppColors.white : AppColors.primaryFontColor),
        ),
      ),
    );
  }
}
