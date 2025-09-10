import 'dart:convert';

import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/const_data.dart';
import 'package:bazaartech/core/const_data/themes.dart';
import 'package:bazaartech/core/service/link.dart';
import 'package:bazaartech/core/service/my_service.dart';
import 'package:bazaartech/core/service/routes.dart';
import 'package:bazaartech/core/service/shared_preferences_key.dart';
import 'package:bazaartech/navbarcontroller.dart';
import 'package:bazaartech/view/account/controller/accountcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

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
    try {
      final myService = Get.find<MyService>();
      final token =
          myService.sharedPreferences.getString(SharedPreferencesKey.tokenKey);
      if (token == null) {
        Get.snackbar("Error", "No token found");
        return;
      }
      final response = await http.post(
        Uri.parse(AppLink.logout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["success"] == true) {
        await myService.sharedPreferences.clear();

        ConstData.token = "";
        AccountController accountController = Get.find<AccountController>();

        accountController.user.value = null;
        accountController.profileImageUrl.value = '';

        Get.find<NavBarController>().changeTabIndex(0);
        Get.offAllNamed(Routes.login);
      } else {
        Get.snackbar("Error", data["message"] ?? "Failed to logout");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
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
          // deleteUserInfo();
          // Get.offAllNamed(Routes.login);
        },
        onCancel: () => Get.back());
  }
}
