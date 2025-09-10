import 'package:bazaartech/widget/customprogressindicator.dart';
import 'package:bazaartech/widget/defaultappbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/view/home/controller/home_controller.dart';
import 'package:bazaartech/view/home/widget/category.dart';
import 'package:bazaartech/view/home/widget/storecard.dart';
import 'package:bazaartech/view/home/widget/productcard.dart';
import 'package:bazaartech/view/home/widget/bazaarcard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
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
            child: GetBuilder<HomeController>(
              builder: (controller) {
                final tabs = ["All", "Products", "Stores", "Bazaars"];
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
            child: GetBuilder<HomeController>(
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
                    _buildAllView(controller),
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

  Widget _buildAllView(HomeController controller) {
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
        itemCount: controller.allItems.length,
        itemBuilder: (context, index) {
          final item = controller.allItems[index];
          if (item['type'] == 'product') {
            return CustomProductCard(data: item['data']);
          } else {
            return CustomStoreCard(data: item['data']);
          }
        },
      ),
    );
  }

  Widget _buildProductsView(HomeController controller) {
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
        itemCount: controller.productCardItem.length,
        itemBuilder: (context, index) {
          return CustomProductCard(data: controller.productCardItem[index]);
        },
      ),
    );
  }

  Widget _buildStoresView(HomeController controller) {
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
        itemCount: controller.storeCardItem.length,
        itemBuilder: (context, index) {
          return CustomStoreCard(data: controller.storeCardItem[index]);
        },
      ),
    );
  }

  Widget _buildBazaarView(HomeController controller) {
    return RefreshIndicator(
      onRefresh: () => controller.refreshData(),
      child: ListView.builder(
        padding:
            EdgeInsets.symmetric(horizontal: MediaQueryUtil.screenWidth / 20.6),
        itemCount: controller.bazaarCardItem.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                EdgeInsets.only(bottom: MediaQueryUtil.screenHeight / 49.64),
            child: CustomBazaarCard(data: controller.bazaarCardItem[index]),
          );
        },
      ),
    );
  }
}
