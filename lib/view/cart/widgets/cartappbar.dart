import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/const_data/font_family.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/core/service/routes.dart';
import 'package:bazaartech/view/account/controller/accountcontroller.dart';
import 'package:bazaartech/widget/loadingphotoappbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CartAppBar({super.key, required this.title});

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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Transform.translate(
                offset: Offset(-MediaQueryUtil.screenWidth / 41.2, 0),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () => Get.back(),
                        icon: Image.asset(AppImages.appbarArrowBack,
                            width: MediaQueryUtil.screenWidth / 17.16)),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: MediaQueryUtil.screenWidth / 12.875,
                        fontFamily: FontFamily.russoOne,
                      ),
                    ),
                  ],
                ),
              ),
              const LoadingProfilePhoto()
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(MediaQueryUtil.screenHeight / 12);
}
