import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/cart/controller/cartcontroller.dart';
import 'package:bazaartech/view/cart/widgets/addresscontainer.dart';
import 'package:bazaartech/view/cart/widgets/cartappbar.dart';
import 'package:bazaartech/view/cart/widgets/completepaymentbutton.dart';
import 'package:bazaartech/view/cart/widgets/paymentcontainer.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CartAppBar(title: 'Checkout'),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQueryUtil.screenWidth / 20.6,
                vertical: MediaQueryUtil.screenHeight / 26.375,
              ),
              child: ListView(
                clipBehavior: Clip.none,
                children: [
                  Text('Delivery To',
                      style: TextStyle(
                        fontSize: MediaQueryUtil.screenWidth / 25.75,
                        color: AppColors.black,
                      )),
                  SizedBox(height: MediaQueryUtil.screenHeight / 70.3),
                  GetBuilder<CartController>(builder: (controller) {
                    return Column(
                      children: [
                        ...controller.addressList.map((addr) {
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom: MediaQueryUtil.screenHeight / 105.5),
                            child: GestureDetector(
                              onTap: () => controller.selectAddress(addr.id),
                              child: AddressContainer(
                                place: addr.place,
                                number: addr.number,
                                address: addr.address,
                                isSelected: addr.isSelected,
                                addressValue: addr.id,
                                onSelect: () =>
                                    controller.selectAddress(addr.id),
                              ),
                            ),
                          );
                        }),
                        SizedBox(height: MediaQueryUtil.screenHeight / 105.5),
                        GestureDetector(
                          onTap: () => controller.showAddAddressDialog(context),
                          child: DottedBorder(
                            color: AppColors.primaryOrangeColor,
                            dashPattern: [
                              MediaQueryUtil.screenWidth / 58.85,
                              MediaQueryUtil.screenWidth / 103,
                            ],
                            strokeWidth: MediaQueryUtil.screenWidth / 274.7,
                            borderType: BorderType.RRect,
                            radius: Radius.circular(
                                MediaQueryUtil.screenWidth / 34.33),
                            child: Container(
                              padding: EdgeInsets.all(
                                  MediaQueryUtil.screenWidth / 25.75),
                              color: AppColors.white,
                              child: Row(
                                children: [
                                  const Icon(Icons.add,
                                      color: AppColors.primaryOrangeColor),
                                  SizedBox(
                                      width: MediaQueryUtil.screenWidth / 51.5),
                                  const Text("Add New Address",
                                      style:
                                          TextStyle(color: AppColors.black60)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                  SizedBox(height: MediaQueryUtil.screenHeight / 26.375),
                  Text('Payment Method',
                      style: TextStyle(
                        fontSize: MediaQueryUtil.screenWidth / 25.75,
                        color: AppColors.black,
                      )),
                  SizedBox(height: MediaQueryUtil.screenHeight / 70.3),
                  PaymentContainer(
                    image: AppImages.syriatelIcon,
                    title: 'Syriatel Cash',
                    paymentMethodValue: 'Syriatel Cash',
                  ),
                  SizedBox(height: MediaQueryUtil.screenHeight / 105.5),
                  PaymentContainer(
                    paymentMethodValue: 'Mtn Mobile Money',
                    image: AppImages.mtnIcon,
                    title: 'Mtn Mobile Money',
                  ),
                ],
              ),
            ),
          ),
          const CompletePaymentButton()
        ],
      ),
    );
  }
}
