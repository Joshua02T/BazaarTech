import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardFavIcon extends StatelessWidget {
  final String id;
  const CardFavIcon({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        bool isHeartFilled = controller.isHeartFilled(id);
        bool isLoading = controller.isHeartLoading(id);
        return GestureDetector(
            onTap: () {
              controller.toggleHeart(id);
            },
            child: GestureDetector(
              onTap: () => controller.toggleHeart(id),
              child: Container(
                width: MediaQueryUtil.screenWidth / 13.73,
                height: MediaQueryUtil.screenHeight / 28.13,
                decoration: BoxDecoration(
                  color: AppColors.primaryOrangeColor,
                  borderRadius:
                      BorderRadius.circular(MediaQueryUtil.screenWidth / 103),
                ),
                child: Center(
                  child: isLoading
                      ? SizedBox(
                          width: MediaQueryUtil.screenWidth / 25.75,
                          height: MediaQueryUtil.screenWidth / 25.75,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.white,
                            backgroundColor: Colors.transparent,
                          ),
                        )
                      : Image.asset(
                          isHeartFilled
                              ? AppImages.filledHeart
                              : AppImages.heart,
                          width: MediaQueryUtil.screenWidth / 25.75,
                        ),
                ),
              ),
            ));
      },
    );
  }
}
