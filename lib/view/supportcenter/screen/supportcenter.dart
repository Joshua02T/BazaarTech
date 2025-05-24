import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/supportcenter/widget/supportfield.dart';
import 'package:bazaartech/widget/customappbarwithback.dart';
import 'package:flutter/material.dart';

class CallSupportCenter extends StatelessWidget {
  const CallSupportCenter({super.key});

  @override
  Widget build(BuildContext context) {
    MediaQueryUtil.init(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CustomAppBarWithBack(text: 'Support Center'),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: MediaQueryUtil.screenHeight / 56.26,
                left: MediaQueryUtil.screenWidth / 20.6,
                right: MediaQueryUtil.screenWidth / 20.6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SupportCenterField(
                    icon: AppImages.telephoneIcon,
                    title: 'Call us on',
                    content: '+963 994 340 513'),
                SizedBox(height: MediaQueryUtil.screenHeight / 56.26),
                SupportCenterField(
                    icon: AppImages.telegramIcon,
                    title: 'Telegram',
                    content: '+963 994 340 513'),
                SizedBox(height: MediaQueryUtil.screenHeight / 56.26),
                SupportCenterField(
                    icon: AppImages.messengerIcon,
                    title: 'Messenger',
                    content: 'BazaarTech'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
