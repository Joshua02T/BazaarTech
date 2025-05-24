import 'dart:math' as math;
import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/settings/controller/settingscontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DarkModeField extends StatelessWidget {
  const DarkModeField({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsController controller = Get.find<SettingsController>();
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
          horizontal: MediaQueryUtil.screenWidth / 20.6,
          vertical: MediaQueryUtil.screenHeight / 84.4),
      leading: Transform.rotate(
        angle: -math.pi / 5,
        child: Image.asset(
          AppImages.darkModeIcon,
          width: MediaQueryUtil.screenWidth / 15,
          height: MediaQueryUtil.screenWidth / 15,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(
        'Dark mode',
        style: TextStyle(
          color: AppColors.primaryFontColor,
          fontSize: MediaQueryUtil.screenWidth / 24,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
            () => Text(
              controller.selectedDarkMode.value,
              style: TextStyle(
                  fontSize: MediaQueryUtil.screenWidth / 25.75,
                  color: AppColors.black60),
            ),
          ),
          SizedBox(width: MediaQueryUtil.screenWidth / 55),
          Obx(() => SizedBox(
                width: MediaQueryUtil.screenWidth / 10,
                child: Transform.scale(
                  scale: 30 / 48,
                  child: Switch(
                    activeTrackColor: AppColors.primaryOrangeColor,
                    inactiveTrackColor: AppColors.settingsLightOrange,
                    activeColor: AppColors.settingsLightOrange,
                    value: controller.switchDarkMode.value,
                    onChanged: (val) {
                      controller.changeMode(val);
                    },
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
