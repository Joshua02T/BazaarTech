import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/navbarcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButtomNavBar extends StatelessWidget {
  final Function(int) onTabSelected;
  const CustomButtomNavBar({super.key, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    MediaQueryUtil.init(context);
    NavBarController controller = Get.put(NavBarController());
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(MediaQueryUtil.screenWidth / 13.73),
        topRight: Radius.circular(MediaQueryUtil.screenWidth / 13.73),
      ),
      child: SizedBox(
        height: MediaQueryUtil.screenHeight / 12,
        child: Obx(() => BottomNavigationBar(
                backgroundColor: AppColors.white,
                type: BottomNavigationBarType.fixed,
                elevation: 0.0,
                currentIndex: controller.selectedIndex.value,
                onTap: (value) {
                  controller.changeTabIndex(value);
                  onTabSelected(value);
                },
                showUnselectedLabels: false,
                showSelectedLabels: true,
                selectedItemColor: AppColors.black,
                selectedLabelStyle:
                    TextStyle(fontSize: MediaQueryUtil.screenWidth / 34.33),
                items: [
                  BottomNavigationBarItem(
                      backgroundColor: AppColors.white,
                      activeIcon: Image.asset(
                        AppImages.homeNavBarSelected,
                        width: MediaQueryUtil.screenWidth / 12.875,
                        color: AppColors.primaryOrangeColor,
                      ),
                      icon: Image.asset(AppImages.homeNavBarUnSelected,
                          width: MediaQueryUtil.screenWidth / 12.875),
                      label: ''),
                  BottomNavigationBarItem(
                      backgroundColor: AppColors.white,
                      activeIcon: Image.asset(AppImages.searchNavBarSelected,
                          width: MediaQueryUtil.screenWidth / 12.875),
                      icon: Image.asset(AppImages.searchNavBarUnSelected,
                          width: MediaQueryUtil.screenWidth / 12.875),
                      label: ''),
                  BottomNavigationBarItem(
                      backgroundColor: AppColors.white,
                      activeIcon: Image.asset(AppImages.heartNavBarSelected,
                          width: MediaQueryUtil.screenWidth / 12.875),
                      icon: Image.asset(AppImages.heartNavBarUnSelected,
                          width: MediaQueryUtil.screenWidth / 12.875),
                      label: ''),
                  BottomNavigationBarItem(
                      backgroundColor: AppColors.white,
                      activeIcon: Image.asset(AppImages.bellNavBarSelected,
                          width: MediaQueryUtil.screenWidth / 12.875),
                      icon: Image.asset(AppImages.bellnavbar,
                          width: MediaQueryUtil.screenWidth / 12.875),
                      label: ''),
                  BottomNavigationBarItem(
                      backgroundColor: AppColors.white,
                      activeIcon: Image.asset(AppImages.settingsNavBarSelected,
                          width: MediaQueryUtil.screenWidth / 12.875),
                      icon: Image.asset(AppImages.settingsnavbar,
                          width: MediaQueryUtil.screenWidth / 12.875),
                      label: ''),
                ])),
      ),
    );
  }
}
