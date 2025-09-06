import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavIcon extends StatelessWidget {
  final String id;
  const FavIcon({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      // bool isHeartFilled = controller.isHeartFilled(id);
      // bool isLoading = controller.isHeartLoading(id);
      return SizedBox(
          width: MediaQueryUtil.screenWidth / 10.04,
          height: MediaQueryUtil.screenHeight / 20.58,
          child: MaterialButton(
              onPressed: () {},
              height: MediaQueryUtil.screenHeight / 20.58,
              padding: EdgeInsets.zero,
              color: AppColors.primaryOrangeColor,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(MediaQueryUtil.screenWidth / 51.5)),
              child:
                  // isLoading
                  //     ? SizedBox(
                  //         width: MediaQueryUtil.screenWidth / 20,
                  //         height: MediaQueryUtil.screenWidth / 20,
                  //         child: const CircularProgressIndicator(
                  //           strokeWidth: 2,
                  //           color: AppColors.white,
                  //           backgroundColor: Colors.transparent,
                  //         ),
                  //       )
                  // :
                  Image.asset(
                      // isHeartFilled ? AppImages.filledHeart :
                      AppImages.heart,
                      width: MediaQueryUtil.screenWidth / 17.16)));
    });
  }
}
