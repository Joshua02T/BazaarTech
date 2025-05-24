import 'dart:io';

import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/themes.dart';
import 'package:bazaartech/core/service/my_service.dart';
import 'package:bazaartech/core/service/routes.dart';
import 'package:bazaartech/view/account/controller/accountcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  RxString selectedLanguage = 'English'.obs;
  RxString selectedDarkMode = 'Off'.obs;
  RxBool switchDarkMode = false.obs;

  void changeMode(bool mode) {
    switchDarkMode.value = mode;
    switch (switchDarkMode.value) {
      case true:
        selectedDarkMode.value = 'On';
        Get.changeTheme(Themes.darkTheme);
        break;
      case false:
        selectedDarkMode.value = 'Off';
        Get.changeTheme(Themes.lightTheme);
        break;
    }
  }

  ThemeData get currentTheme =>
      switchDarkMode.value ? Themes.darkTheme : Themes.lightTheme;

  void changeLanguage(String language) {
    selectedLanguage.value = language;
  }

  void showLanguageDialog() {
    Get.defaultDialog(
      title: 'Choose Language',
      titleStyle: const TextStyle(color: AppColors.primaryOrangeColor),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text('English'),
            onTap: () {
              changeLanguage('English');
              Get.back();
            },
          ),
          ListTile(
            title: const Text('العربية'),
            onTap: () {
              changeLanguage('العربية');
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  Future<void> deleteUserInfo() async {
    final myService = Get.find<MyService>();
    myService.sharedPreferences.clear();
    final tempFile = File('${Directory.systemTemp.path}/profile_image.jpg');
    if (await tempFile.exists()) {
      await tempFile.delete();
    }
    AccountController accountController = Get.find<AccountController>();
    accountController.profileImage.value = null;
  }

  Future<void> logout() async {
    Get.defaultDialog(
        title: 'Logout',
        titleStyle: const TextStyle(color: AppColors.primaryFontColor),
        middleText: 'You sure you want to log out?',
        middleTextStyle: const TextStyle(color: AppColors.primaryOrangeColor),
        backgroundColor: AppColors.white,
        buttonColor: AppColors.primaryOrangeColor,
        cancelTextColor: AppColors.primaryFontColor,
        textConfirm: 'Logout!',
        textCancel: 'Cancel',
        confirmTextColor: AppColors.white,
        onConfirm: () async {
          deleteUserInfo();
          Get.offAllNamed(Routes.login);
        },
        onCancel: () => Get.back());
  }

  Future<void> deleteAccount() async {
    Get.defaultDialog(
        title: 'Delete Account',
        titleStyle: const TextStyle(color: AppColors.primaryFontColor),
        middleText: 'You sure you want to delete your Account?',
        middleTextStyle: const TextStyle(color: AppColors.primaryOrangeColor),
        backgroundColor: AppColors.white,
        buttonColor: AppColors.primaryOrangeColor,
        cancelTextColor: AppColors.primaryFontColor,
        textConfirm: 'Delete!',
        textCancel: 'Cancel',
        confirmTextColor: AppColors.white,
        onConfirm: () async {
          deleteUserInfo();
          Get.offAllNamed(Routes.login);
        },
        onCancel: () => Get.back());
  }
}
