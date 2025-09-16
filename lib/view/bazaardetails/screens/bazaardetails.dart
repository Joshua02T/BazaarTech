import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/const_data/font_family.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/core/service/routes.dart';
import 'package:bazaartech/view/bazaardetails/controller/bazaardetailscontroller.dart';
import 'package:bazaartech/view/bazaardetails/widgets/ratingwidget.dart';
import 'package:bazaartech/view/storedetails/widgets/customcategory.dart';
import 'package:bazaartech/view/storedetails/widgets/storeproductcard.dart';
import 'package:bazaartech/widget/commentwidget.dart';
import 'package:bazaartech/widget/customdetailsfavicon.dart';
import 'package:bazaartech/widget/customdetailsiconback.dart';
import 'package:bazaartech/widget/customprogressindicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BazaarDetails extends StatelessWidget {
  final String id;
  const BazaarDetails({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    Get.put(BazaarDetailsController(id));

    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: GetBuilder<BazaarDetailsController>(
          builder: (controller) {
            if (controller.isLoadingFetching) {
              return const Center(child: CustomProgressIndicator());
            }
            if (controller.bazaar == null) {
              return Center(
                  child: Text('Store not found',
                      style: TextStyle(
                          fontSize: MediaQueryUtil.screenWidth / 25.75,
                          color: AppColors.black60)));
            }
            final bazaar = controller.bazaar!;
            return Stack(children: [
              GestureDetector(
                onTap: () => showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                          backgroundColor: Colors.transparent,
                          child: InteractiveViewer(
                            child: CachedNetworkImage(
                              imageUrl: bazaar.image,
                              placeholder: (context, url) => const Center(
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                AppImages.bazaarimage1,
                              ),
                            ),
                          ));
                    }),
                child: CachedNetworkImage(
                  imageUrl: bazaar.image,
                  fit: BoxFit.cover,
                  height: MediaQueryUtil.screenHeight / 2.11,
                  width: double.infinity,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    AppImages.productPhoto,
                    fit: BoxFit.cover,
                    height: MediaQueryUtil.screenHeight / 2.11,
                    width: double.infinity,
                  ),
                ),
              ),
              const CustomDetailsIconBack(),
              DraggableScrollableSheet(
                initialChildSize: MediaQueryUtil.screenHeight / 1298.46,
                minChildSize: MediaQueryUtil.screenHeight / 1383.6,
                maxChildSize: MediaQueryUtil.screenHeight / 992.94,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Container(
                    padding: EdgeInsets.only(
                        top: MediaQueryUtil.screenHeight / 42.2,
                        bottom: MediaQueryUtil.screenHeight / 42.2),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(
                                MediaQueryUtil.screenWidth / 9.15)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: MediaQueryUtil.screenWidth / 41.2,
                              offset: const Offset(0, -2))
                        ]),
                    child: ListView(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQueryUtil.screenWidth / 20.6),
                      controller: scrollController,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              bazaar.name,
                              style: TextStyle(
                                fontSize: MediaQueryUtil.screenWidth / 17.16,
                                color: AppColors.primaryFontColor,
                                fontFamily: FontFamily.russoOne,
                              ),
                            ),
                            FavIcon(kind: 'bazaar', id: id),
                          ],
                        ),
                        Text(
                          bazaar.details,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontSize: MediaQueryUtil.screenWidth / 25.75,
                            color: AppColors.black60,
                          ),
                        ),
                        SizedBox(height: MediaQueryUtil.screenHeight / 35),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  AppImages.bazaarClock,
                                  width: MediaQueryUtil.screenWidth / 25.75,
                                ),
                                Text(
                                  '  ${bazaar.firstDate}  -  ${bazaar.lastDate}',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQueryUtil.screenWidth / 25.75,
                                    color: AppColors.darkGrey,
                                  ),
                                ),
                              ],
                            ),
                            if (bazaar.status.isNotEmpty)
                              Row(
                                children: [
                                  Image.asset(
                                    AppImages.postionPin,
                                    width: MediaQueryUtil.screenWidth / 25.75,
                                  ),
                                  Text(
                                    ' ${bazaar.status}',
                                    style: TextStyle(
                                        fontSize:
                                            MediaQueryUtil.screenWidth / 25.75,
                                        color: AppColors.darkGrey),
                                  )
                                ],
                              )
                          ],
                        ),
                        SizedBox(height: MediaQueryUtil.screenHeight / 26.375),
                        Text('Products',
                            style: TextStyle(
                                fontSize: MediaQueryUtil.screenWidth / 17.16,
                                color: AppColors.primaryFontColor,
                                fontFamily: FontFamily.russoOne)),
                        SizedBox(height: MediaQueryUtil.screenHeight / 52.75),
                        controller.productCategories.isEmpty
                            ? Center(
                                child: Text("There are no products available",
                                    style: TextStyle(
                                        fontSize:
                                            MediaQueryUtil.screenWidth / 29.42,
                                        color: AppColors.primaryFontColor)))
                            : Column(children: [
                                SizedBox(
                                    height: MediaQueryUtil.screenHeight / 22.81,
                                    child: ListView.builder(
                                        clipBehavior: Clip.none,
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            controller.productCategories.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                              onTap: () {
                                                controller
                                                    .updateSelectedProductCategoryIndex(
                                                        index);
                                                controller.pageController
                                                    .animateToPage(
                                                  index,
                                                  duration: const Duration(
                                                      milliseconds: 200),
                                                  curve: Curves.fastOutSlowIn,
                                                );
                                              },
                                              child: CustomProductCategory(
                                                  title: controller
                                                      .productCategories[index]
                                                      .name,
                                                  isSelected: controller
                                                          .selectedProductCategoryIndex ==
                                                      index));
                                        })),
                                SizedBox(
                                    height: MediaQueryUtil.screenHeight / 3.3,
                                    child: PageView.builder(
                                        clipBehavior: Clip.none,
                                        controller: controller.pageController,
                                        onPageChanged: (index) {
                                          controller
                                              .updateSelectedProductCategoryIndex(
                                                  index);
                                        },
                                        itemCount:
                                            controller.productCategories.length,
                                        itemBuilder: (context, index) {
                                          final selectedCategory = controller
                                              .productCategories[index];
                                          final filteredProducts = controller
                                                  .bazaar?.products
                                                  .where((product) =>
                                                      product.category ==
                                                      selectedCategory.name)
                                                  .toList() ??
                                              [];

                                          return filteredProducts.isEmpty
                                              ? Center(
                                                  child: Text(
                                                      "No products in this category",
                                                      style: TextStyle(
                                                          fontSize: MediaQueryUtil
                                                                  .screenWidth /
                                                              29.42,
                                                          color: AppColors
                                                              .primaryFontColor)))
                                              : GridView.builder(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    mainAxisExtent:
                                                        MediaQueryUtil
                                                                .screenHeight /
                                                            3.8,
                                                    crossAxisSpacing:
                                                        MediaQueryUtil
                                                                .screenWidth /
                                                            27.46,
                                                    mainAxisSpacing:
                                                        MediaQueryUtil
                                                                .screenHeight /
                                                            49.64,
                                                  ),
                                                  itemCount: filteredProducts
                                                              .length >=
                                                          2
                                                      ? 2
                                                      : filteredProducts.length,
                                                  itemBuilder:
                                                      (context, productIndex) {
                                                    return CustomStoreProductCard(
                                                        data: filteredProducts[
                                                            productIndex]);
                                                  });
                                        })),
                                MaterialButton(
                                    onPressed: () {
                                      Get.toNamed(Routes.bazaarProducts,
                                          arguments: controller
                                                  .productCategories[
                                              controller
                                                  .selectedProductCategoryIndex]);
                                    },
                                    color: AppColors.backgroundColor,
                                    elevation: 0.0,
                                    height: MediaQueryUtil.screenHeight / 32.46,
                                    minWidth: double.infinity,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          MediaQueryUtil.screenWidth / 103),
                                    ),
                                    child: Text('Show all',
                                        style: TextStyle(
                                            fontSize:
                                                MediaQueryUtil.screenWidth /
                                                    34.33,
                                            color: AppColors.black60)))
                              ]),
                        SizedBox(height: MediaQueryUtil.screenHeight / 50),
                        Text('Reviews',
                            style: TextStyle(
                                fontSize: MediaQueryUtil.screenWidth / 17.16,
                                color: AppColors.primaryFontColor,
                                fontFamily: FontFamily.russoOne)),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              controller.comments.isNotEmpty
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: 2,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                            onTap: () => Get.toNamed(
                                                    Routes.bazaarReviews,
                                                    arguments: {
                                                      "id": bazaar.id.toString()
                                                    }),
                                            child: CommentWidget(
                                                comment: controller
                                                    .comments[index]));
                                      })
                                  : Center(
                                      child: Text('No Reviews!',
                                          style: TextStyle(
                                              fontSize:
                                                  MediaQueryUtil.screenWidth /
                                                      25.75,
                                              color: AppColors.black60))),
                              MaterialButton(
                                  onPressed: () => Get.toNamed(
                                      Routes.bazaarReviews,
                                      arguments: {"id": bazaar.id.toString()}),
                                  color: AppColors.backgroundColor,
                                  elevation: 0.0,
                                  height: MediaQueryUtil.screenHeight / 32.46,
                                  minWidth: double.infinity,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      MediaQueryUtil.screenWidth / 103,
                                    ),
                                  ),
                                  child: Text(
                                      controller.comments.isNotEmpty
                                          ? 'Show all'
                                          : 'Add Review',
                                      style: TextStyle(
                                          fontSize: MediaQueryUtil.screenWidth /
                                              34.33,
                                          color: AppColors.black60))),
                              SizedBox(
                                  height: MediaQueryUtil.screenHeight / 26.375),
                              Text('Rate this bazaar!',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQueryUtil.screenWidth / 17.16,
                                      color: AppColors.primaryFontColor,
                                      fontFamily: FontFamily.russoOne)),
                              RatingWidget(userRate: bazaar.userRate)
                            ])
                      ],
                    ),
                  );
                },
              )
            ]);
          },
        ));
  }
}
