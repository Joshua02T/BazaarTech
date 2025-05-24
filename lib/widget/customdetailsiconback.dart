import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CustomDetailsIconBack extends StatelessWidget {
  const CustomDetailsIconBack({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => Get.back(),
        child: Padding(
            padding: EdgeInsets.only(
                left: MediaQueryUtil.screenWidth / 20.6,
                top: MediaQueryUtil.screenHeight / 25),
            child: Container(
                width: MediaQueryUtil.screenWidth / 9.58,
                height: MediaQueryUtil.screenHeight / 19.62,
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(
                        MediaQueryUtil.screenWidth / 51.5)),
                child: Center(
                    child: Image.asset(AppImages.appbarArrowBack,
                        width: MediaQueryUtil.screenWidth / 17.16)))));
  }
}
