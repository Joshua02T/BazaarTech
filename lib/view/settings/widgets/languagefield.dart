import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/settings/controller/settingscontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageField extends StatelessWidget {
  const LanguageField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SettingsController controller = Get.find<SettingsController>();
    return ListTile(
      onTap: () => controller.showLanguageDialog(),
      contentPadding: EdgeInsets.symmetric(
        horizontal: MediaQueryUtil.screenWidth / 20.6,
        vertical: MediaQueryUtil.screenHeight / 84.4,
      ),
      leading: Image.asset(
        AppImages.translateIcon,
        width: MediaQueryUtil.screenWidth / 15,
        height: MediaQueryUtil.screenWidth / 15,
        fit: BoxFit.contain,
      ),
      title: Text(
        'Language',
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
              controller.selectedLanguage.value,
              style: TextStyle(
                fontSize: MediaQueryUtil.screenWidth / 25.75,
                color: AppColors.black60,
              ),
            ),
          ),
          SizedBox(width: MediaQueryUtil.screenWidth / 55),
          Image.asset(
            AppImages.iosArrowright,
            width: MediaQueryUtil.screenWidth / 20.6,
            color: AppColors.primaryOrangeColor,
          ),
        ],
      ),
    );
  }
}
