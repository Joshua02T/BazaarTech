import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/const_data/font_family.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/cart/controller/locationpicker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetLocationAppbar extends StatelessWidget implements PreferredSizeWidget {
  final LocationPickerController controller;
  const GetLocationAppbar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    MediaQueryUtil.init(context);
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(MediaQueryUtil.screenHeight / 24.14)),
      child: AppBar(
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
                      'Pick Location',
                      style: TextStyle(
                        fontSize: MediaQueryUtil.screenWidth / 12.875,
                        fontFamily: FontFamily.russoOne,
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => controller.isLoadingCurrentLocation.value
                    ? CircularProgressIndicator(
                        color: AppColors.primaryOrangeColor,
                        strokeWidth: MediaQueryUtil.screenWidth / 206,
                      )
                    : IconButton(
                        icon: const Icon(Icons.my_location),
                        tooltip: "Use Current Location",
                        onPressed: controller.moveToCurrentLocation,
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(MediaQueryUtil.screenHeight / 12);
}
