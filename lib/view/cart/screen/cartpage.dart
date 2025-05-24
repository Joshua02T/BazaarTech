import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/cart/controller/cartcontroller.dart';
import 'package:bazaartech/view/cart/models/cartitemmodel.dart';
import 'package:bazaartech/view/cart/widgets/cartappbar.dart';
import 'package:bazaartech/view/cart/widgets/cartitem.dart';
import 'package:bazaartech/view/cart/widgets/checkoutbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CartAppBar(title: 'Cart'),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return cartController.uniqueMarkerNames.isEmpty
                  ? Center(
                      child: Text('Empty!',
                          style: TextStyle(
                              fontSize: MediaQueryUtil.screenWidth / 25.75,
                              color: AppColors.black60)))
                  : Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQueryUtil.screenHeight / 26.375,
                          horizontal: MediaQueryUtil.screenWidth / 20.6),
                      child: ListView.builder(
                        clipBehavior: Clip.none,
                        itemCount: cartController.uniqueMarkerNames.length,
                        itemBuilder: (context, index) {
                          String markerName =
                              cartController.uniqueMarkerNames[index];
                          List<CartItemModel> products =
                              cartController.getProductsByMarker(markerName);
                          return CartItem(
                            markerName: markerName,
                            products: products,
                          );
                        },
                      ),
                    );
            }),
          ),
          const CheckoutButton(),
        ],
      ),
    );
  }
}
