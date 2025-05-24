import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/const_data/font_family.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/core/service/routes.dart';
import 'package:bazaartech/view/home/widget/cardfavicon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomStoreCard extends StatelessWidget {
  final dynamic data;
  const CustomStoreCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.storeDetails, arguments: {"id": data.id}),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius:
                BorderRadius.circular(MediaQueryUtil.screenWidth / 51.5)),
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  data.image,
                  height: MediaQueryUtil.screenHeight / 5.41,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
                Transform.translate(
                  offset: Offset(MediaQueryUtil.screenWidth / 3.296,
                      MediaQueryUtil.screenHeight / 84.4),
                  child: Container(
                    width: MediaQueryUtil.screenWidth / 10.56,
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(
                            MediaQueryUtil.screenWidth / 103)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(data.rating.toInt().toString(),
                            style: TextStyle(
                                fontSize: MediaQueryUtil.screenWidth / 25.75,
                                color: AppColors.black)),
                        Image.asset(
                          AppImages.starIcon,
                          width: MediaQueryUtil.screenWidth / 25.75,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: MediaQueryUtil.screenHeight / 140),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQueryUtil.screenWidth / 25.75),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.name,
                          style: TextStyle(
                              fontSize: MediaQueryUtil.screenWidth / 17.16,
                              color: AppColors.black,
                              fontFamily: FontFamily.russoOne),
                        ),
                        Row(children: [
                          Image.asset(AppImages.postionPin,
                              width: MediaQueryUtil.screenWidth / 41.2),
                          SizedBox(width: MediaQueryUtil.screenWidth / 103),
                          Text(data.address,
                              style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: MediaQueryUtil.screenWidth / 41.2)),
                        ])
                      ]),
                  CardFavIcon(id: data.id)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
