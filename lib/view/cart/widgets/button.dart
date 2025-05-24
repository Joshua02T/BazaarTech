import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:flutter/material.dart';

class CustomCartButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  const CustomCartButton(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: AppColors.primaryOrangeColor,
      minWidth: double.infinity,
      height: MediaQueryUtil.screenHeight / 20.58,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(MediaQueryUtil.screenWidth / 51.5)),
      child: Text(
        text,
        style: TextStyle(
            color: AppColors.white,
            fontSize: MediaQueryUtil.screenWidth / 25.75),
      ),
    );
  }
}
