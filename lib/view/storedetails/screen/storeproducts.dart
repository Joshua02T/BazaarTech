import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/model/categorymodel.dart';
import 'package:bazaartech/view/home/widget/productcard.dart';
import 'package:bazaartech/view/storedetails/controller/storeproductscontroller.dart';
import 'package:bazaartech/widget/customappbarwithback.dart';
import 'package:bazaartech/widget/customprogressindicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreProducts extends StatelessWidget {
  final Category category;

  const StoreProducts({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    Get.put(StoreProductsController(category.id.toString()));

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBarWithBack(text: category.name),
      body: GetBuilder<StoreProductsController>(
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(child: CustomProgressIndicator());
          }

          if (controller.products.isEmpty) {
            return RefreshIndicator(
              onRefresh: () async {
                await controller
                    .loadProductsBasedOnCategoryId(category.id.toString());
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(
                    height: 400,
                    child: Center(child: Text("No products available")),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await controller
                  .loadProductsBasedOnCategoryId(category.id.toString());
            },
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQueryUtil.screenHeight / 52.75,
                left: MediaQueryUtil.screenWidth / 20.6,
                right: MediaQueryUtil.screenWidth / 20.6,
              ),
              child: GridView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                clipBehavior: Clip.none,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: MediaQueryUtil.screenHeight / 3.8,
                  crossAxisSpacing: MediaQueryUtil.screenWidth / 27.46,
                  mainAxisSpacing: MediaQueryUtil.screenHeight / 49.64,
                ),
                itemCount: controller.products.length,
                itemBuilder: (context, productIndex) {
                  return CustomProductCard(
                    data: controller.products[productIndex],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
