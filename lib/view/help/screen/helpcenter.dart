import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/const_data/font_family.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/core/service/routes.dart';
import 'package:bazaartech/view/help/controller/helpcentercontroller.dart';
import 'package:bazaartech/widget/customlisttile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({super.key});

  @override
  Widget build(BuildContext context) {
    HelpCenterController controller = Get.put(HelpCenterController());
    MediaQueryUtil.init(context);
    return Scaffold(
      backgroundColor: AppColors.primaryOrangeColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: MediaQueryUtil.screenHeight / 14.3,
                left: MediaQueryUtil.screenWidth / 20.6,
                right: MediaQueryUtil.screenWidth / 20.6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        width: MediaQueryUtil.screenWidth / 9.8,
                        height: MediaQueryUtil.screenHeight / 20.09,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          color: AppColors.backgroundColor,
                        ),
                        child: Center(
                          child: Image.asset(
                            AppImages.appbarArrowBack,
                            width: MediaQueryUtil.screenWidth / 20.6,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: MediaQueryUtil.screenWidth / 20.6),
                    Text(
                      'Help Center',
                      style: TextStyle(
                        fontSize: MediaQueryUtil.screenWidth / 12.875,
                        color: AppColors.white,
                        fontFamily: FontFamily.russoOne,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQueryUtil.screenHeight / 42.2),
                Text(
                  'Hello Joshua, What\'s wrong!',
                  style: TextStyle(
                    fontSize: MediaQueryUtil.screenWidth / 25.75,
                    color: const Color.fromRGBO(255, 255, 255, 0.5),
                    fontWeight: FontWeight.w500,
                    fontFamily: FontFamily.montserrat,
                    letterSpacing: MediaQueryUtil.screenWidth / 206,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQueryUtil.screenHeight / 16.88),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(MediaQueryUtil.screenWidth / 11.77),
                  topRight: Radius.circular(MediaQueryUtil.screenWidth / 11.77),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQueryUtil.screenWidth / 20.6,
                        right: MediaQueryUtil.screenWidth / 20.6,
                        top: MediaQueryUtil.screenHeight / 21.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => controller.performSpeedTest(),
                          child: Container(
                            padding: EdgeInsets.only(
                                left: MediaQueryUtil.screenWidth / 51.5,
                                right: MediaQueryUtil.screenWidth / 51.5,
                                top: MediaQueryUtil.screenHeight / 52.75),
                            width: MediaQueryUtil.screenWidth / 2.35,
                            decoration: BoxDecoration(
                                color: AppColors.primaryOrangeColor,
                                borderRadius: BorderRadius.circular(
                                    MediaQueryUtil.screenWidth / 25.75)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Speed\ntest internet',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQueryUtil.screenWidth / 22.88,
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                Obx(() {
                                  if (controller.isLoading.value) {
                                    return const Text('Loading...');
                                  } else {
                                    return Text(controller.downloadSpeed.value);
                                  }
                                }),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Image.asset(
                                    AppImages.speedInternetIcon,
                                    width: MediaQueryUtil.screenWidth / 8.24,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => controller.performPingTest(),
                          child: Container(
                            padding: EdgeInsets.only(
                                left: MediaQueryUtil.screenWidth / 51.5,
                                right: MediaQueryUtil.screenWidth / 51.5,
                                top: MediaQueryUtil.screenHeight / 52.75),
                            width: MediaQueryUtil.screenWidth / 2.35,
                            decoration: BoxDecoration(
                                color: AppColors.primaryOrangeColor,
                                borderRadius: BorderRadius.circular(
                                    MediaQueryUtil.screenWidth / 25.75)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Quality\nof connection',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQueryUtil.screenWidth / 22.88,
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w500),
                                ),
                                Obx(() {
                                  if (controller.isLoadingPing.value) {
                                    return const Text('Loading...');
                                  } else {
                                    return Text(
                                        controller.connectionQuality.value);
                                  }
                                }),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Image.asset(
                                    AppImages.wifiIcon,
                                    width: MediaQueryUtil.screenWidth / 8.24,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQueryUtil.screenHeight / 50),
                  CustomListTile(
                      icon: AppImages.aboutAppIcon,
                      title: 'About App',
                      wheretogo: () => Get.toNamed(Routes.aboutApp)),
                  const Divider(thickness: 1, height: 0),
                  CustomListTile(
                      icon: AppImages.reportProblem,
                      title: 'Report a Problem',
                      wheretogo: () => Get.toNamed(Routes.reportAProblem)),
                  const Divider(thickness: 1, height: 0),
                  CustomListTile(
                      icon: AppImages.callSupportCenter,
                      title: 'Call Support Center',
                      wheretogo: () => Get.toNamed(Routes.supportcenter)),
                  const Divider(thickness: 1, height: 0),
                  CustomListTile(
                      icon: AppImages.termsIcon,
                      title: 'Terms & Policies',
                      wheretogo: () => Get.toNamed(Routes.privacy)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
