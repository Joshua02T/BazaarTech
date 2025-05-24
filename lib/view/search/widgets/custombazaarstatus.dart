import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:flutter/material.dart';

class CustomBazaarStatusContainer extends StatelessWidget {
  final String bazaarStatus;
  final bool isSelected;
  const CustomBazaarStatusContainer(
      {super.key, required this.bazaarStatus, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQueryUtil.screenWidth / 3.58,
      height: MediaQueryUtil.screenHeight / 21.1,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryOrangeColor : AppColors.white,
        borderRadius: BorderRadius.circular(MediaQueryUtil.screenWidth / 51.5),
      ),
      child: Center(
        child: Text(
          bazaarStatus,
          style: TextStyle(
            color: isSelected ? AppColors.white : AppColors.primaryFontColor,
            fontSize: MediaQueryUtil.screenWidth / 25.75,
          ),
        ),
      ),
    );
  }
}
