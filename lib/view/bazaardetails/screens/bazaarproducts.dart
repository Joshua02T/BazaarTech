import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/bazaardetails/controller/bazaardetailscontroller.dart';
import 'package:bazaartech/view/home/widget/productcard.dart';
import 'package:bazaartech/widget/customappbarwithback.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BazaarProducts extends StatelessWidget {
  const BazaarProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final BazaarDetailsController controller =
        Get.find<BazaarDetailsController>();
    final String selectedCategory = Get.arguments ?? 'Products';
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBarWithBack(text: selectedCategory),
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQueryUtil.screenHeight / 52.75,
          left: MediaQueryUtil.screenWidth / 20.6,
          right: MediaQueryUtil.screenWidth / 20.6,
        ),
        child: GridView.builder(
          clipBehavior: Clip.none,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: MediaQueryUtil.screenHeight / 3.8,
            crossAxisSpacing: MediaQueryUtil.screenWidth / 27.46,
            mainAxisSpacing: MediaQueryUtil.screenHeight / 49.64,
          ),
          itemCount: controller.filteredProductsForCurrentCategory.length,
          itemBuilder: (context, productIndex) {
            return CustomProductCard(
                data: controller
                    .filteredProductsForCurrentCategory[productIndex]);
          },
        ),
      ),
    );
  }
}
