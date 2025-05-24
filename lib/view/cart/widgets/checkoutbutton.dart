import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/font_family.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/core/service/routes.dart';
import 'package:bazaartech/view/cart/controller/cartcontroller.dart';
import 'package:bazaartech/view/cart/widgets/button.dart';
import 'package:bazaartech/widget/customtoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.find<CartController>();
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(MediaQueryUtil.screenWidth / 10),
        topRight: Radius.circular(MediaQueryUtil.screenWidth / 10),
      ),
      child: Container(
        color: AppColors.white,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              MediaQueryUtil.screenWidth / 20.6,
              MediaQueryUtil.screenHeight / 26.375,
              MediaQueryUtil.screenWidth / 20.6,
              MediaQueryUtil.screenHeight / 56.26),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: MediaQueryUtil.screenWidth / 25.75,
                      color: AppColors.primaryFontColor,
                      fontFamily: FontFamily.russoOne,
                    ),
                  ),
                  GetBuilder<CartController>(
                    builder: (controller) {
                      double totalPrice = controller.getSubTotalPrice();
                      return RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '\$ ',
                              style: TextStyle(
                                fontSize: MediaQueryUtil.screenWidth / 28,
                                color: AppColors.primaryFontColor,
                                fontFamily: FontFamily.russoOne,
                              ),
                            ),
                            TextSpan(
                              text: '${totalPrice.toInt()}',
                              style: TextStyle(
                                fontSize: MediaQueryUtil.screenWidth / 25.75,
                                color: AppColors.primaryFontColor,
                                fontFamily: FontFamily.montserrat,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
              const Divider(),
              CustomCartButton(
                  text: 'Checkout',
                  onPressed: () {
                    if (cartController.uniqueMarkerNames.isNotEmpty) {
                      Get.toNamed(Routes.checkoutPage);
                    } else {
                      ToastUtil.showToast('Cart is empty!');
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
