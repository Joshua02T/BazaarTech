import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardFavIcon extends StatelessWidget {
  final String kind;
  final String id;

  const CardFavIcon({
    super.key,
    required this.kind,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        final isLoading = controller.isLoadingAddingToFavorite[id] == true;
        final isFav = controller.getIsFavorite(kind, id);

        return GestureDetector(
          onTap: () => controller.addOrRemoveFavorite(kind, id),
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
                      isFav ? AppImages.filledHeart : AppImages.heart,
                      width: MediaQueryUtil.screenWidth / 25.75,
                    ),
            ),
          ),
        );
      },
    );
  }
}
