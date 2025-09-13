import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/account/controller/accountcontroller.dart';
import 'package:bazaartech/view/favorite/screen/favorite.dart';
import 'package:bazaartech/view/home/screen/home_screen.dart';
import 'package:bazaartech/view/notifications/screen/notifications.dart';
import 'package:bazaartech/view/search/screen/search.dart';
import 'package:bazaartech/view/settings/screen/settings.dart';
import 'package:bazaartech/widget/custombottmnavbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'navbarcontroller.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    NavBarController controller = Get.put(NavBarController(), permanent: true);
    MediaQueryUtil.init(context);
    Get.put(AccountController());

    return Obx(() => Scaffold(
          backgroundColor: AppColors.backgroundColor,
          body: IndexedStack(
            index: controller.selectedIndex.value,
            children: [
              _buildPage(0, const HomeScreen()),
              _buildPage(1, const Search()),
              _buildPage(2, const Favorite()),
              _buildPage(3, const Notifications()),
              _buildPage(4, const Settings()),
            ],
          ),
          bottomNavigationBar: CustomButtomNavBar(
            onTabSelected: (index) {
              controller.changeTabIndex(index);
            },
          ),
        ));
  }

  Widget _buildPage(int index, Widget page) {
    final NavBarController controller = Get.find<NavBarController>();
    return Obx(() {
      if (controller.selectedIndex.value == index) {
        return page;
      } else {
        controller.deleteController(index);
        return const SizedBox.shrink();
      }
    });
  }
}
