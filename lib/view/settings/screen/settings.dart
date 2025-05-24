import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/core/service/routes.dart';
import 'package:bazaartech/view/settings/controller/settingscontroller.dart';
import 'package:bazaartech/view/settings/widgets/languagefield.dart';
import 'package:bazaartech/view/settings/widgets/modefield.dart';
import 'package:bazaartech/widget/customlisttile.dart';
import 'package:bazaartech/widget/defaultappbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsController controller = Get.find<SettingsController>();
    MediaQueryUtil.init(context);
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: const DefaultAppBar(title: 'Settings'),
        body: ListView(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const LanguageField(),
            const Divider(thickness: 1, height: 0),
            const DarkModeField(),
            const Divider(thickness: 1, height: 0),
            CustomListTile(
                icon: AppImages.helpIcon,
                title: 'Help',
                wheretogo: () => Get.toNamed(Routes.helpCenter)),
            const Divider(thickness: 1, height: 0),
            CustomListTile(
                icon: AppImages.logoutIcon,
                title: 'Log out',
                wheretogo: () => controller.logout()),
            const Divider(thickness: 1, height: 0),
            CustomListTile(
                icon: AppImages.deleteIAccountIcon,
                title: 'Delete account',
                wheretogo: () => controller.deleteAccount()),
          ])
        ]));
  }
}
