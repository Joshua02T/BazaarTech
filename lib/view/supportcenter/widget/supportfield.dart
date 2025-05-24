import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:flutter/material.dart';

class SupportCenterField extends StatelessWidget {
  final String icon, title, content;

  const SupportCenterField(
      {super.key,
      required this.icon,
      required this.title,
      required this.content});

  @override
  Widget build(BuildContext context) {
    MediaQueryUtil.init(context);
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: MediaQueryUtil.screenWidth / 34.33),
      height: MediaQueryUtil.screenHeight / 16.23,
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(MediaQueryUtil.screenWidth / 34.33),
          border: Border.all(color: AppColors.primaryOrangeColor)),
      child: Row(
        children: [
          Image.asset(icon, width: MediaQueryUtil.screenWidth / 16.48),
          SizedBox(width: MediaQueryUtil.screenWidth / 20.6),
          Text(title,
              style: TextStyle(
                  fontSize: MediaQueryUtil.screenWidth / 20.6,
                  color: AppColors.primaryFontColor)),
          SizedBox(width: MediaQueryUtil.screenWidth / 20.6),
          Text(
            content,
            style: TextStyle(
                fontSize: MediaQueryUtil.screenWidth / 20.6,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryFontColor),
          ),
          if (content == 'BazaarTech')
            Padding(
              padding:
                  EdgeInsets.only(left: MediaQueryUtil.screenWidth / 34.33),
              child: Image.asset(
                AppImages.facebookIcon,
                width: MediaQueryUtil.screenWidth / 20.6,
              ),
            ),
        ],
      ),
    );
  }
}
