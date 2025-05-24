import 'dart:math' as math;

import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/const_data/font_family.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/cart/controller/cartcontroller.dart';
import 'package:bazaartech/view/cart/models/cartitemmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class SlidableCartCard extends StatelessWidget {
  final CartItemModel cartItemModel;
  const SlidableCartCard({super.key, required this.cartItemModel});

  @override
  Widget build(BuildContext context) {
    final product = cartItemModel.product;
    final CartController cartController = Get.find<CartController>();
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQueryUtil.screenHeight / 84.4),
      child: Slidable(
          endActionPane: ActionPane(
            extentRatio: MediaQueryUtil.screenWidth / 3433.3,
            motion: GestureDetector(
              onTap: () => cartController.removeFromCart(cartItemModel),
              child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.slidableDeleteColor,
                      borderRadius: BorderRadius.circular(
                          MediaQueryUtil.screenWidth / 34.33)),
                  child: Center(
                      child: Image.asset(AppImages.trashIcon,
                          width: MediaQueryUtil.screenWidth / 20.6))),
            ),
            children: const [],
          ),
          child: Container(
            padding: EdgeInsets.all(MediaQueryUtil.screenWidth / 25.75),
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius:
                    BorderRadius.circular(MediaQueryUtil.screenWidth / 34.33)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Image.asset(product.image,
                      width: MediaQueryUtil.screenWidth / 6.43,
                      height: MediaQueryUtil.screenHeight / 13.1875),
                  SizedBox(width: MediaQueryUtil.screenWidth / 25.75),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.name,
                            style: TextStyle(
                                fontSize: MediaQueryUtil.screenWidth / 22.88,
                                color: AppColors.black,
                                fontFamily: FontFamily.russoOne)),
                        if (product.size.isNotEmpty)
                          Text('Size: ${product.size}',
                              style: TextStyle(
                                  fontSize: MediaQueryUtil.screenWidth / 25.75,
                                  color: AppColors.black60)),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: '${product.price} ',
                              style: TextStyle(
                                  fontSize: MediaQueryUtil.screenWidth / 25.75,
                                  color: AppColors.primaryFontColor,
                                  fontFamily: FontFamily.montserrat)),
                          TextSpan(
                              text: '\$  ',
                              style: TextStyle(
                                  fontSize: MediaQueryUtil.screenWidth / 34.3,
                                  color: AppColors.black,
                                  fontFamily: FontFamily.russoOne)),
                          if (product.status == 'DISCOUNT')
                            TextSpan(
                                text: '${product.oldPrice}',
                                style: TextStyle(
                                    fontSize: MediaQueryUtil.screenWidth / 34.3,
                                    color: AppColors.black60,
                                    decoration: TextDecoration.lineThrough,
                                    fontFamily: FontFamily.montserrat))
                        ]))
                      ])
                ]),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () =>
                          cartController.increaseQuantity(cartItemModel),
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.secondaryOrangeColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                    MediaQueryUtil.screenWidth / 68.6),
                                topRight: Radius.circular(
                                    MediaQueryUtil.screenWidth / 68.6))),
                        width: MediaQueryUtil.screenWidth / 14.71,
                        height: MediaQueryUtil.screenHeight / 42.2,
                        child: Center(
                          child: Transform.rotate(
                            angle: math.pi / 2,
                            child: Image.asset(
                              AppImages.appbarArrowBack,
                              width: MediaQueryUtil.screenWidth / 25.75,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: MediaQueryUtil.screenHeight / 422,
                      ),
                      child: GetBuilder<CartController>(
                          builder: (controller) => Text(
                              '${cartItemModel.quantity}',
                              style: TextStyle(
                                  fontSize: MediaQueryUtil.screenWidth / 25.75,
                                  color: AppColors.black60))),
                    ),
                    GestureDetector(
                      onTap: () =>
                          cartController.decreaseQuantity(cartItemModel),
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.secondaryOrangeColor,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(
                                    MediaQueryUtil.screenWidth / 68.6),
                                bottomLeft: Radius.circular(
                                    MediaQueryUtil.screenWidth / 68.6))),
                        width: MediaQueryUtil.screenWidth / 14.71,
                        height: MediaQueryUtil.screenHeight / 42.2,
                        child: Center(
                          child: Transform.rotate(
                            angle: -math.pi / 2,
                            child: Image.asset(
                              AppImages.appbarArrowBack,
                              width: MediaQueryUtil.screenWidth / 25.75,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
