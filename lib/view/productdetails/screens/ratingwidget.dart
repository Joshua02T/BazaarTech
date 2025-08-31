import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/productdetails/controller/productdetailscontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RatingWidget extends StatelessWidget {
  final int userRate;
  const RatingWidget({super.key, required this.userRate});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsController>(
      builder: (controller) {
        if (controller.rating == 0 && userRate > 0) {
          controller.setRating(userRate);
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return IconButton(
              onPressed: () => controller.setRating(index + 1),
              icon: Image.asset(
                AppImages.starIcon,
                width: MediaQueryUtil.screenWidth / 11.77,
                color: index < controller.rating
                    ? AppColors.primaryOrangeColor
                    : AppColors.lightOrangeColor,
              ),
            );
          }),
        );
      },
    );
  }
}
