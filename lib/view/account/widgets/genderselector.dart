import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/account/controller/accountcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class GenderSelector extends StatelessWidget {
  final AccountController controller;
  final String imagename;
  final String gender;
  const GenderSelector(
      {super.key,
      required this.controller,
      required this.imagename,
      required this.gender});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => controller.selectGender(gender),
        child: Obx(() => Container(
            width: MediaQueryUtil.screenWidth / 7.49,
            height: MediaQueryUtil.screenHeight / 15.345,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: controller.selectedGender.value == gender
                  ? AppColors.primaryOrangeColor
                  : AppColors.lightGrey,
            ),
            child: Center(
                child: Image.asset(imagename,
                    width: MediaQueryUtil.screenWidth / 16.48,
                    color: controller.selectedGender.value == gender
                        ? AppColors.white
                        : AppColors.darkGrey)))));
  }
}
