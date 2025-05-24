import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:flutter/material.dart';

class CustomRatingContainer extends StatelessWidget {
  final String ratingNumber;
  final bool isSelected;
  const CustomRatingContainer(
      {super.key, required this.ratingNumber, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQueryUtil.screenWidth / 9.36,
      height: MediaQueryUtil.screenHeight / 19.18,
      margin: EdgeInsets.only(right: MediaQueryUtil.screenWidth / 25.75),
      decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryOrangeColor : AppColors.white,
          borderRadius:
              BorderRadius.circular(MediaQueryUtil.screenWidth / 51.5)),
      child: Center(
        child: Text(
          ratingNumber,
          style: TextStyle(
              color: isSelected ? AppColors.white : AppColors.black,
              fontSize: MediaQueryUtil.screenWidth / 25.75),
        ),
      ),
    );
  }
}
