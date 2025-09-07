import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/const_data/font_family.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBarWithBack extends StatelessWidget
    implements PreferredSizeWidget {
  final String text;

  const CustomAppBarWithBack({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    MediaQueryUtil.init(context);
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(MediaQueryUtil.screenHeight / 24.14)),
      child: AppBar(
        backgroundColor: AppColors.white,
        scrolledUnderElevation: 0.0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.only(top: MediaQueryUtil.screenHeight / 50),
          child: Transform.translate(
            offset: Offset(-MediaQueryUtil.screenWidth / 41.2, 0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () => Get.back(),
                    icon: Image.asset(AppImages.appbarArrowBack,
                        width: MediaQueryUtil.screenWidth / 17.16)),
                Flexible(
                  child: Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: MediaQueryUtil.screenWidth / 12.875,
                      fontFamily: FontFamily.russoOne,
                    ),
                  ),
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
