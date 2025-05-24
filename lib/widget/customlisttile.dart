import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final void Function() wheretogo;
  final String title;
  final String icon;

  const CustomListTile({
    super.key,
    required this.wheretogo,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: wheretogo,
        contentPadding: EdgeInsets.symmetric(
            horizontal: MediaQueryUtil.screenWidth / 20.6,
            vertical: MediaQueryUtil.screenHeight / 84.4),
        leading: Image.asset(
          color: AppColors.primaryOrangeColor,
          icon,
          width: MediaQueryUtil.screenWidth / 15,
          height: MediaQueryUtil.screenWidth / 15,
          fit: BoxFit.contain,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: AppColors.primaryFontColor,
            fontSize: MediaQueryUtil.screenWidth / 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Image.asset(AppImages.iosArrowright,
            width: MediaQueryUtil.screenWidth / 20.6,
            color: AppColors.primaryOrangeColor));
  }
}
