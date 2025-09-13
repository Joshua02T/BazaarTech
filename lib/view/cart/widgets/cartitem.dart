import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/font_family.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/cart/models/cartitemmodel.dart';
import 'package:bazaartech/view/cart/widgets/slidable.dart';
import 'package:flutter/material.dart';

class CartItemContainer extends StatelessWidget {
  final String markerName;
  final List<CartItem> products;

  const CartItemContainer(
      {super.key, required this.markerName, required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: MediaQueryUtil.screenHeight / 20.58,
              decoration: BoxDecoration(
                  color: AppColors.primaryOrangeColor,
                  borderRadius: BorderRadius.only(
                      topLeft:
                          Radius.circular(MediaQueryUtil.screenWidth / 34.33),
                      topRight:
                          Radius.circular(MediaQueryUtil.screenWidth / 34.33))),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQueryUtil.screenWidth / 25.75,
                  vertical: MediaQueryUtil.screenHeight / 84.4),
              child: Text(
                markerName,
                style: TextStyle(
                    color: AppColors.white,
                    fontSize: MediaQueryUtil.screenWidth / 22.88,
                    fontFamily: FontFamily.russoOne),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQueryUtil.screenHeight / 168.8,
                decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft:
                            Radius.circular(MediaQueryUtil.screenWidth / 34.33),
                        topRight: Radius.circular(
                            MediaQueryUtil.screenWidth / 34.33))),
              ),
            ),
          ],
        ),
        SizedBox(height: MediaQueryUtil.screenHeight / 105.5),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: products.length,
          itemBuilder: (context, index) {
            return SlidableCartCard(cartItem: products[index]);
          },
        ),
        SizedBox(height: MediaQueryUtil.screenHeight / 26.375),
      ],
    );
  }
}
