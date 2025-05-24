import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/my_text.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/privacy/widget/privacyappbar.dart';
import 'package:flutter/material.dart';

class Privacy extends StatelessWidget {
  const Privacy({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryUtil.init(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CustomPrivacyAppBar(),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQueryUtil.screenWidth / 20.6,
                vertical: MediaQueryUtil.screenHeight / 49.64),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Privacy Policy',
                  style: TextStyle(
                      fontSize: MediaQueryUtil.screenWidth / 20.6,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryFontColor),
                ),
                SizedBox(height: MediaQueryUtil.screenHeight / 42.2),
                Text(
                  'Last updated: December 12, 2024',
                  style: TextStyle(
                      fontSize: MediaQueryUtil.screenWidth / 29.42,
                      color: AppColors.primaryFontColor),
                ),
                SizedBox(height: MediaQueryUtil.screenHeight / 120.75),
                Text(
                  MyText.privacy,
                  style: TextStyle(
                      fontSize: MediaQueryUtil.screenWidth / 29.42,
                      color: AppColors.primaryFontColor),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
