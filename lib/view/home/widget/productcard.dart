import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/const_data/font_family.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/core/service/routes.dart';
import 'package:bazaartech/view/cart/controller/cartcontroller.dart';
import 'package:bazaartech/view/home/model/productmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomProductCard extends StatelessWidget {
  final Product data;
  const CustomProductCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Get.toNamed(Routes.productDetails, arguments: {"id": data.id}),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius:
                BorderRadius.circular(MediaQueryUtil.screenWidth / 51.5)),
        child: Column(
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: data.image,
                  fit: BoxFit.fill,
                  height: MediaQueryUtil.screenHeight / 5.41,
                  width: double.infinity,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    AppImages.productPhoto,
                    fit: BoxFit.fill,
                    height: MediaQueryUtil.screenHeight / 5.41,
                    width: double.infinity,
                  ),
                ),
                if (data.status != 'NONE')
                  Transform.translate(
                    offset: Offset(
                      MediaQueryUtil.screenWidth / 2.8,
                      MediaQueryUtil.screenHeight / 84.4,
                    ),
                    child: IntrinsicWidth(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        height: MediaQueryUtil.screenHeight / 46.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              MediaQueryUtil.screenWidth / 103),
                          color: AppColors.primaryOrangeColor,
                        ),
                        child: Center(
                          child: Text(
                            data.status,
                            style: TextStyle(
                              fontSize: MediaQueryUtil.screenWidth / 41.2,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                Transform.translate(
                  offset: Offset(MediaQueryUtil.screenWidth / 3.58,
                      MediaQueryUtil.screenHeight / 6.7),
                  child: Container(
                    width: MediaQueryUtil.screenWidth / 7.22,
                    height: MediaQueryUtil.screenHeight / 40.19,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            MediaQueryUtil.screenWidth / 103),
                        color: AppColors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            '${data.price.toInt()} ',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: MediaQueryUtil.screenWidth / 25.75,
                                color: AppColors.black,
                                fontFamily: FontFamily.russoOne),
                          ),
                        ),
                        Text(
                          '\$',
                          style: TextStyle(
                              fontSize: MediaQueryUtil.screenWidth / 34.33,
                              color: AppColors.primaryOrangeColor,
                              fontFamily: FontFamily.russoOne),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: MediaQueryUtil.screenHeight / 64.92),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQueryUtil.screenWidth / 25.75),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            data.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: MediaQueryUtil.screenWidth / 25.75,
                                color: AppColors.black,
                                fontFamily: FontFamily.russoOne),
                          ),
                          Text(data.markerName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: MediaQueryUtil.screenWidth / 41.2)),
                        ]),
                  ),
                  GestureDetector(
                      onTap: () => Get.find<CartController>().addToCart(data),
                      child: Container(
                        width: MediaQueryUtil.screenWidth / 13.73,
                        height: MediaQueryUtil.screenHeight / 28.13,
                        decoration: BoxDecoration(
                            color: AppColors.primaryOrangeColor,
                            borderRadius: BorderRadius.circular(
                                MediaQueryUtil.screenWidth / 103)),
                        child: Center(
                            child: Image.asset(
                          AppImages.bagIcon,
                          color: AppColors.white,
                          width: MediaQueryUtil.screenWidth / 22.88,
                        )),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
