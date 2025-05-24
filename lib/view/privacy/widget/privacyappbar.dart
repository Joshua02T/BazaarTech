import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/const_data/font_family.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomPrivacyAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomPrivacyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(MediaQueryUtil.screenHeight / 24.14)),
      child: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: AppColors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(top: MediaQueryUtil.screenHeight / 50),
          child: Transform.translate(
            offset: Offset(-MediaQueryUtil.screenWidth / 41.2, 0),
            child: Row(
              children: [
                IconButton(
                    onPressed: () => Get.back(),
                    icon: Image.asset(AppImages.appbarArrowBack,
                        width: MediaQueryUtil.screenWidth / 17.16)),
                Text(
                  'BazaarTech',
                  style: TextStyle(
                      fontSize: MediaQueryUtil.screenWidth / 12.875,
                      fontFamily: FontFamily.russoOne,
                      color: AppColors.primaryOrangeColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(MediaQueryUtil.screenHeight / 12);
}
