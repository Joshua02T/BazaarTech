import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/cart/controller/cartcontroller.dart';
import 'package:bazaartech/view/cart/controller/checkoutcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentContainer extends StatelessWidget {
  final String image;
  final String title;
  final int paymentMethodValue;

  const PaymentContainer({
    super.key,
    required this.image,
    required this.title,
    required this.paymentMethodValue,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutController>(
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            controller.changePaymentMethod(paymentMethodValue);
          },
          child: Container(
            width: double.infinity,
            height: MediaQueryUtil.screenHeight / 12.41,
            padding: EdgeInsets.symmetric(
              horizontal: MediaQueryUtil.screenWidth / 25.75,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius:
                  BorderRadius.circular(MediaQueryUtil.screenWidth / 51.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(image,
                        width: MediaQueryUtil.screenWidth / 7.49),
                    SizedBox(width: MediaQueryUtil.screenWidth / 34.33),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: MediaQueryUtil.screenWidth / 25.75,
                        color: AppColors.black60,
                      ),
                    ),
                  ],
                ),
                Radio(
                  activeColor: AppColors.primaryOrangeColor,
                  value: paymentMethodValue,
                  groupValue: controller.paymentMethod,
                  onChanged: (val) {
                    controller.changePaymentMethod(val!);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
