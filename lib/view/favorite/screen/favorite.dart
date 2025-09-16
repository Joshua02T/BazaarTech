import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/favorite/controller/favcontroller.dart';
import 'package:bazaartech/view/home/widget/bazaarcard.dart';
import 'package:bazaartech/view/home/widget/category.dart';
import 'package:bazaartech/view/home/widget/productcard.dart';
import 'package:bazaartech/view/home/widget/storecard.dart';
import 'package:bazaartech/widget/customprogressindicator.dart';
import 'package:bazaartech/widget/defaultappbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(FavoriteController());
    return Scaffold(
      appBar: const DefaultAppBar(title: 'Explore'),
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: MediaQueryUtil.screenHeight / 52.75,
              left: MediaQueryUtil.screenWidth / 20.6,
              right: MediaQueryUtil.screenWidth / 20.6,
            ),
            child: GetBuilder<FavoriteController>(
              builder: (controller) {
                final tabs = ["Products", "Stores", "Bazaars"];
                return SizedBox(
                  height: MediaQueryUtil.screenHeight / 22.81,
                  child: ListView.builder(
                    clipBehavior: Clip.none,
                    itemCount: tabs.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final isSelected = controller.selectedIndex == index;
                      return GestureDetector(
                        onTap: () {
                          controller.updateSelectedIndex(index);
                          controller.pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.fastOutSlowIn,
                          );
                        },
                        child: CustomCategory(
                          title: tabs[index],
                          isSelected: isSelected,
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          SizedBox(height: MediaQueryUtil.screenHeight / 40),
          Expanded(
            child: GetBuilder<FavoriteController>(
              builder: (controller) {
                if (controller.isLoading) {
                  return const CustomProgressIndicator();
                }
                return PageView(
                  controller: controller.pageController,
                  onPageChanged: (index) {
                    controller.updateSelectedIndex(index);
                  },
                  children: [
                    _buildProductsView(controller),
                    _buildStoresView(controller),
                    _buildBazaarView(controller)
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsView(FavoriteController controller) {
    return RefreshIndicator(
      onRefresh: () => controller.refreshData(),
      child: GridView.builder(
        padding:
            EdgeInsets.symmetric(horizontal: MediaQueryUtil.screenWidth / 20.6),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: MediaQueryUtil.screenHeight / 3.8,
          crossAxisSpacing: MediaQueryUtil.screenWidth / 27.46,
          mainAxisSpacing: MediaQueryUtil.screenHeight / 49.64,
        ),
        itemCount: controller.productsInFav.length,
        itemBuilder: (context, index) {
          return CustomProductCard(data: controller.productsInFav[index]);
        },
      ),
    );
  }

  Widget _buildStoresView(FavoriteController controller) {
    return RefreshIndicator(
      onRefresh: () => controller.refreshData(),
      child: GridView.builder(
        padding:
            EdgeInsets.symmetric(horizontal: MediaQueryUtil.screenWidth / 20.6),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: MediaQueryUtil.screenHeight / 3.8,
          crossAxisSpacing: MediaQueryUtil.screenWidth / 27.46,
          mainAxisSpacing: MediaQueryUtil.screenHeight / 49.64,
        ),
        itemCount: controller.storseInFav.length,
        itemBuilder: (context, index) {
          return CustomStoreCard(data: controller.storseInFav[index]);
        },
      ),
    );
  }

  Widget _buildBazaarView(FavoriteController controller) {
    return RefreshIndicator(
      onRefresh: () => controller.refreshData(),
      child: ListView.builder(
        padding:
            EdgeInsets.symmetric(horizontal: MediaQueryUtil.screenWidth / 20.6),
        itemCount: controller.bazaarsInFav.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                EdgeInsets.only(bottom: MediaQueryUtil.screenHeight / 49.64),
            child: CustomBazaarCard(data: controller.bazaarsInFav[index]),
          );
        },
      ),
    );
  }
}
