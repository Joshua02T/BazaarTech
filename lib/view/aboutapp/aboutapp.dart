import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/const_data/font_family.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/widget/customappbarwithback.dart';
import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryUtil.init(context);
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: const CustomAppBarWithBack(text: 'About App'),
        body: Padding(
            padding: EdgeInsets.only(top: MediaQueryUtil.screenHeight / 33.76),
            child: Center(
                child: Column(children: [
              Image.asset(
                AppImages.appIcon,
                width: MediaQueryUtil.screenWidth / 5.88,
              ),
              SizedBox(height: MediaQueryUtil.screenHeight / 52.75),
              Text('BazaarTech',
                  style: TextStyle(
                      fontSize: MediaQueryUtil.screenWidth / 22.8,
                      fontFamily: FontFamily.russoOne,
                      color: AppColors.primaryFontColor)),
              Text('App version 1.0.0',
                  style: TextStyle(
                      fontSize: MediaQueryUtil.screenWidth / 25.75,
                      color: AppColors.darkGrey))
            ]))));
  }
}
