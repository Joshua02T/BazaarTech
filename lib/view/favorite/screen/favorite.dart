import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/lists.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/favorite/controller/favcontroller.dart';
import 'package:bazaartech/view/home/controller/home_controller.dart';
import 'package:bazaartech/view/home/model/bazaarmodel.dart';
import 'package:bazaartech/view/home/model/productmodel.dart';
import 'package:bazaartech/view/home/model/storemodel.dart';
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
    final HomeController homeController = Get.find<HomeController>();
    final FavoriteController favoriteController =
        Get.find<FavoriteController>();

    return Scaffold(
        appBar: const DefaultAppBar(title: 'Favorites'),
        backgroundColor: AppColors.backgroundColor,
        body: Container()
        // GetBuilder<FavoriteController>(
        //   builder: (controller) {
        //     if (favoriteController.isLoading) {
        //       return const Center(child: CustomProgressIndicator());
        //     }
        //     return Column(
        //       children: [
        //         Padding(
        //           padding: EdgeInsets.only(
        //             top: MediaQueryUtil.screenHeight / 52.75,
        //             left: MediaQueryUtil.screenWidth / 20.6,
        //             right: MediaQueryUtil.screenWidth / 20.6,
        //           ),
        //           child: SizedBox(
        //             height: MediaQueryUtil.screenHeight / 22.81,
        //             child: ListView.builder(
        //               clipBehavior: Clip.none,
        //               itemCount: searchCategoryItem.length,
        //               scrollDirection: Axis.horizontal,
        //               itemBuilder: (context, index) {
        //                 final isSelected =
        //                     favoriteController.selectedIndex == index;
        //                 return GestureDetector(
        //                     onTap: () {
        //                       favoriteController.updateSelectedIndex(index);
        //                       favoriteController.pageController.animateToPage(
        //                         index,
        //                         duration: const Duration(milliseconds: 1),
        //                         curve: Curves.fastOutSlowIn,
        //                       );
        //                     },
        //                     child: CustomCategory(
        //                       title: searchCategoryItem[index],
        //                       isSelected: isSelected,
        //                     ));
        //               },
        //             ),
        //           ),
        //         ),
        //         SizedBox(height: MediaQueryUtil.screenHeight / 40),
        //         Expanded(
        //           child: PageView.builder(
        //             controller: favoriteController.pageController,
        //             onPageChanged: favoriteController.updateSelectedIndex,
        //             itemCount: 3,
        //             itemBuilder: (context, pageIndex) {
        //               final filteredItems =
        //                   homeController.favoriteItems.where((item) {
        //                 if (pageIndex == 0) return item['type'] == 'product';

        //                 if (pageIndex == 1) return item['type'] == 'store';
        //                 if (pageIndex == 2) return item['type'] == 'bazaar';
        //                 return true;
        //               }).toList();

        //               if (filteredItems.isEmpty) {
        //                 return Center(
        //                   child: Text(
        //                     'No ${searchCategoryItem[pageIndex].toLowerCase()} in favorites',
        //                     style: TextStyle(
        //                       fontSize: MediaQueryUtil.screenWidth / 25.75,
        //                       color: AppColors.black60,
        //                     ),
        //                   ),
        //                 );
        //               }

        //               if (pageIndex == 2) {
        //                 return ListView.builder(
        //                   itemCount: filteredItems.length,
        //                   padding: EdgeInsets.symmetric(
        //                       horizontal: MediaQueryUtil.screenWidth / 20.6),
        //                   itemBuilder: (context, index) {
        //                     final item = filteredItems[index];
        //                     return Padding(
        //                       padding: EdgeInsets.only(
        //                           bottom: MediaQueryUtil.screenHeight / 49.64),
        //                       child: CustomBazaarCard(
        //                           data: item['data'] as Bazaar),
        //                     );
        //                   },
        //                 );
        //               }

        //               return GridView.builder(
        //                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //                   crossAxisCount: 2,
        //                   mainAxisExtent: MediaQueryUtil.screenHeight / 3.8,
        //                   crossAxisSpacing: MediaQueryUtil.screenWidth / 27.46,
        //                   mainAxisSpacing: MediaQueryUtil.screenHeight / 49.64,
        //                 ),
        //                 padding: EdgeInsets.symmetric(
        //                     horizontal: MediaQueryUtil.screenWidth / 20.6),
        //                 itemCount: filteredItems.length,
        //                 itemBuilder: (context, index) {
        //                   final item = filteredItems[index];
        //                   if (pageIndex == 0) {
        //                     return CustomProductCard(
        //                         data: item['data'] as Product);
        //                   } else {
        //                     return CustomStoreCard(data: item['data'] as Store);
        //                   }
        //                 },
        //               );
        //             },
        //           ),
        //         ),
        //       ],
        //     );
        //   },
        // )
        );
  }
}
