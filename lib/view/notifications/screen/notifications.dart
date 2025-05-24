import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/view/notifications/controller/noticontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    NotificationsController controller = Get.find<NotificationsController>();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Container(),
    );
  }
}
