import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/const_data/font_family.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/core/service/routes.dart';
import 'package:bazaartech/view/home/model/bazaarmodel.dart';
import 'package:bazaartech/view/home/widget/cardfavicon.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBazaarCard extends StatelessWidget {
  final Bazaar data;
  const CustomBazaarCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Get.toNamed(Routes.bazaarDetails, arguments: {"id": data.id}),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius:
              BorderRadius.circular(MediaQueryUtil.screenWidth / 51.5),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQueryUtil.screenWidth / 3.81,
              width: MediaQueryUtil.screenWidth / 3.81,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(MediaQueryUtil.screenWidth / 51.5),
                color: AppColors.white,
              ),
              clipBehavior: Clip.hardEdge,
              child: CachedNetworkImage(
                imageUrl: data.image,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                errorWidget: (context, url, error) => Image.asset(
                  AppImages.productPhoto,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: MediaQueryUtil.screenWidth / 25.75),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQueryUtil.screenHeight / 52.75,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name,
                      style: TextStyle(
                        fontSize: MediaQueryUtil.screenWidth / 22.8,
                        color: AppColors.black,
                        fontFamily: FontFamily.russoOne,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      data.details,
                      style: TextStyle(
                        fontSize: MediaQueryUtil.screenWidth / 41.2,
                        color: AppColors.darkGrey,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    SizedBox(height: MediaQueryUtil.screenHeight / 56.26),
                    Row(
                      children: [
                        Image.asset(
                          AppImages.bazaarClock,
                          width: MediaQueryUtil.screenWidth / 34.33,
                        ),
                        SizedBox(width: MediaQueryUtil.screenWidth / 51.5),
                        Flexible(
                          child: Text(
                            data.firstDate,
                            style: TextStyle(
                              fontSize: MediaQueryUtil.screenWidth / 41.2,
                              color: AppColors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: MediaQueryUtil.screenWidth / 20.6),
                        SizedBox(
                          width: MediaQueryUtil.screenWidth / 11.77,
                          child: const Divider(
                            color: AppColors.black,
                          ),
                        ),
                        SizedBox(width: MediaQueryUtil.screenWidth / 20.6),
                        Flexible(
                          child: Text(
                            data.lastDate,
                            style: TextStyle(
                              fontSize: MediaQueryUtil.screenWidth / 41.2,
                              color: AppColors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: MediaQueryUtil.screenHeight / 46.88,
                horizontal: MediaQueryUtil.screenWidth / 51.5,
              ),
              child: SizedBox(
                width: MediaQueryUtil.screenWidth / 14.71,
                height: MediaQueryUtil.screenHeight / 30.14,
                child: const CardFavIcon(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
