import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/core/service/routes.dart';
import 'package:bazaartech/view/cart/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmationPage extends StatelessWidget {
  const ConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryOrangeColor,
      body: Column(
        children: [
          SizedBox(height: MediaQueryUtil.screenHeight / 4),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(MediaQueryUtil.screenWidth / 11.77),
                  topRight: Radius.circular(MediaQueryUtil.screenWidth / 11.77),
                ),
              ),
              child: Padding(
                padding:
                    EdgeInsets.only(top: MediaQueryUtil.screenHeight / 5.94),
                child: Column(
                  children: [
                    Image.asset(
                      AppImages.confirmedIcon,
                      width: MediaQueryUtil.screenWidth / 3.43,
                    ),
                    SizedBox(height: MediaQueryUtil.screenHeight / 17.22),
                    Text(
                      'Successful !',
                      style: TextStyle(
                        fontSize: MediaQueryUtil.screenWidth / 25.75,
                        color: AppColors.primaryFontColor,
                      ),
                    ),
                    const Spacer(),
                    Text('Thank you for shopping',
                        style: TextStyle(
                          fontSize: MediaQueryUtil.screenWidth / 25.75,
                          color: AppColors.primaryFontColor,
                        )),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQueryUtil.screenHeight / 56.26,
                            horizontal: MediaQueryUtil.screenWidth / 20.6),
                        child: CustomCartButton(
                            text: 'Continue Shopping',
                            onPressed: () => Get.offAllNamed(Routes.mainPage))),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
