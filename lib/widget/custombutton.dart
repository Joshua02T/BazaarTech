import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/text_style.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  const CustomButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    MediaQueryUtil.init(context);
    return MaterialButton(
      onPressed: onPressed,
      color: AppColors.primaryOrangeColor,
      textColor: AppColors.white,
      minWidth: MediaQueryUtil.screenWidth / 1.08,
      height: MediaQueryUtil.screenHeight / 12.98,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(MediaQueryUtil.screenWidth / 34.33)),
      child: Text(
        title,
        style: FontStyles.buttonTextStyle(context),
      ),
    );
  }
}
