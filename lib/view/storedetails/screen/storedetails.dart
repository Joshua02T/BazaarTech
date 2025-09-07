import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/const_data/font_family.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/core/service/routes.dart';
import 'package:bazaartech/model/commentmodel.dart';
import 'package:bazaartech/view/home/model/storemodel.dart';
import 'package:bazaartech/view/storedetails/controller/storedetailscontroller.dart';
import 'package:bazaartech/view/storedetails/widgets/customcategory.dart';
import 'package:bazaartech/view/storedetails/widgets/ratingwidget.dart';
import 'package:bazaartech/view/storedetails/widgets/storeproductcard.dart';
import 'package:bazaartech/widget/commentwidget.dart';
import 'package:bazaartech/widget/customdetailsfavicon.dart';
import 'package:bazaartech/widget/customdetailsiconback.dart';
import 'package:bazaartech/widget/customprogressindicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StoreDetails extends StatelessWidget {
  final String id;
  const StoreDetails({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    Get.put(StoreDetailsController(id));

    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: GetBuilder<StoreDetailsController>(
          builder: (controller) {
            if (controller.isLoadingFetching) {
              return const Center(child: CustomProgressIndicator());
            }
            if (controller.store == null) {
              return Center(
                  child: Text('Store not found',
                      style: TextStyle(
                          fontSize: MediaQueryUtil.screenWidth / 25.75,
                          color: AppColors.black60)));
            }
            final store = controller.store!;

            return Stack(children: [
              GestureDetector(
                onTap: () => showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                          backgroundColor: Colors.transparent,
                          child: InteractiveViewer(
                            child: CachedNetworkImage(
                              imageUrl: store.image,
                              placeholder: (context, url) => const Center(
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                AppImages.storePhoto,
                              ),
                            ),
                          ));
                    }),
                child: CachedNetworkImage(
                  imageUrl: store.image,
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
                  builder: (BuildContext context,
                      ScrollController scrollController) {
                    return Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(
                                    MediaQueryUtil.screenWidth / 9.15)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: MediaQueryUtil.screenWidth / 41.2,
                                  offset: const Offset(0, -2))
                            ]),
                        child: Column(children: [
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQueryUtil.screenHeight / 42.2,
                                      bottom:
                                          MediaQueryUtil.screenHeight / 42.2),
                                  child: ListView(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              MediaQueryUtil.screenWidth /
                                                  20.6),
                                      controller: scrollController,
                                      children: [
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(store.name,
                                                  style: TextStyle(
                                                      fontSize: MediaQueryUtil
                                                              .screenWidth /
                                                          17.16,
                                                      color: AppColors
                                                          .primaryFontColor,
                                                      fontFamily:
                                                          FontFamily.russoOne)),
                                              Row(
                                                  children:
                                                      List.generate(5, (index) {
                                                return Padding(
                                                    padding: EdgeInsets.only(
                                                      left: MediaQueryUtil
                                                              .screenWidth /
                                                          103,
                                                    ),
                                                    child: Image.asset(
                                                        index < store.rating
                                                            ? AppImages.starIcon
                                                            : AppImages
                                                                .unFilledStarIcon,
                                                        width: MediaQueryUtil
                                                                .screenWidth /
                                                            17.16));
                                              }))
                                            ]),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(store.sort,
                                                  style: TextStyle(
                                                      fontSize: MediaQueryUtil
                                                              .screenWidth /
                                                          25.75,
                                                      color:
                                                          AppColors.black60)),
                                              store.comments.isNotEmpty
                                                  ? Row(children: [
                                                      Text(
                                                          store.comments.length
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontSize:
                                                                  MediaQueryUtil
                                                                          .screenWidth /
                                                                      25.75,
                                                              color: AppColors
                                                                  .black60)),
                                                      Text(
                                                          store.comments
                                                                      .length ==
                                                                  1
                                                              ? ' Review'
                                                              : ' Reviews',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  MediaQueryUtil
                                                                          .screenWidth /
                                                                      25.75,
                                                              color: AppColors
                                                                  .black60))
                                                    ])
                                                  : Text('No reviews!',
                                                      style: TextStyle(
                                                          fontSize: MediaQueryUtil
                                                                  .screenWidth /
                                                              25.75,
                                                          color: AppColors
                                                              .black60))
                                            ]),
                                        SizedBox(
                                            height:
                                                MediaQueryUtil.screenHeight /
                                                    31.25),
                                        SizedBox(
                                            width: MediaQueryUtil.screenWidth /
                                                1.03,
                                            height: MediaQueryUtil
                                                    .screenHeight /
                                                6.7,
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        MediaQueryUtil
                                                                .screenWidth /
                                                            25.75),
                                                child: GoogleMap(
                                                    initialCameraPosition:
                                                        CameraPosition(
                                                            target: LatLng(
                                                                store.latitude,
                                                                store
                                                                    .longitude),
                                                            zoom: 15),
                                                    markers: {
                                                      Marker(
                                                          markerId:
                                                              const MarkerId(
                                                                  "location"),
                                                          position: LatLng(
                                                              store.latitude,
                                                              store.longitude),
                                                          icon: BitmapDescriptor
                                                              .defaultMarkerWithHue(
                                                                  BitmapDescriptor
                                                                      .hueRed))
                                                    },
                                                    mapType: MapType.normal,
                                                    zoomControlsEnabled:
                                                        false))),
                                        SizedBox(
                                            height:
                                                MediaQueryUtil.screenHeight /
                                                    26.375),
                                        Text('Products',
                                            style: TextStyle(
                                                fontSize:
                                                    MediaQueryUtil.screenWidth /
                                                        17.16,
                                                color:
                                                    AppColors.primaryFontColor,
                                                fontFamily:
                                                    FontFamily.russoOne)),
                                        SizedBox(
                                            height:
                                                MediaQueryUtil.screenHeight /
                                                    52.75),
                                        controller.productCategories.isEmpty
                                            ? Center(
                                                child: Text(
                                                    "There are no products available",
                                                    style: TextStyle(
                                                        fontSize: MediaQueryUtil
                                                                .screenWidth /
                                                            29.42,
                                                        color: AppColors
                                                            .primaryFontColor)))
                                            : Column(children: [
                                                SizedBox(
                                                    height: MediaQueryUtil
                                                            .screenHeight /
                                                        22.81,
                                                    child: ListView.builder(
                                                        clipBehavior: Clip.none,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        itemCount: controller
                                                            .productCategories
                                                            .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return GestureDetector(
                                                              onTap: () {
                                                                controller
                                                                    .updateSelectedProductCategoryIndex(
                                                                        index);
                                                                controller
                                                                    .pageController
                                                                    .animateToPage(
                                                                  index,
                                                                  duration: const Duration(
                                                                      milliseconds:
                                                                          200),
                                                                  curve: Curves
                                                                      .fastOutSlowIn,
                                                                );
                                                              },
                                                              child: CustomProductCategory(
                                                                  title: controller
                                                                          .productCategories[
                                                                      index],
                                                                  isSelected:
                                                                      controller
                                                                              .selectedProductCategoryIndex ==
                                                                          index));
                                                        })),
                                                SizedBox(
                                                    height: MediaQueryUtil
                                                            .screenHeight /
                                                        3.3,
                                                    child: PageView.builder(
                                                        clipBehavior: Clip.none,
                                                        controller: controller
                                                            .pageController,
                                                        onPageChanged: (index) {
                                                          controller
                                                              .updateSelectedProductCategoryIndex(
                                                                  index);
                                                        },
                                                        itemCount: controller
                                                            .productCategories
                                                            .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          final selectedCategory =
                                                              controller
                                                                      .productCategories[
                                                                  index];
                                                          final filteredProducts = controller
                                                                  .store
                                                                  ?.products
                                                                  .where((product) =>
                                                                      product
                                                                          .category ==
                                                                      selectedCategory)
                                                                  .toList() ??
                                                              [];

                                                          return filteredProducts
                                                                  .isEmpty
                                                              ? Center(
                                                                  child: Text(
                                                                      "No products in this category",
                                                                      style: TextStyle(
                                                                          fontSize: MediaQueryUtil.screenWidth /
                                                                              29.42,
                                                                          color: AppColors
                                                                              .primaryFontColor)))
                                                              : GridView
                                                                  .builder(
                                                                      physics:
                                                                          const NeverScrollableScrollPhysics(),
                                                                      shrinkWrap:
                                                                          true,
                                                                      gridDelegate:
                                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                                        crossAxisCount:
                                                                            2,
                                                                        mainAxisExtent:
                                                                            MediaQueryUtil.screenHeight /
                                                                                3.8,
                                                                        crossAxisSpacing:
                                                                            MediaQueryUtil.screenWidth /
                                                                                27.46,
                                                                        mainAxisSpacing:
                                                                            MediaQueryUtil.screenHeight /
                                                                                49.64,
                                                                      ),
                                                                      itemCount: filteredProducts.length >=
                                                                              2
                                                                          ? 2
                                                                          : filteredProducts
                                                                              .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              productIndex) {
                                                                        return CustomStoreProductCard(
                                                                            data:
                                                                                filteredProducts[productIndex]);
                                                                      });
                                                        })),
                                                MaterialButton(
                                                    onPressed: () {
                                                      Get.toNamed(
                                                          Routes.storeProducts,
                                                          arguments: controller
                                                                  .productCategories[
                                                              controller
                                                                  .selectedProductCategoryIndex]);
                                                    },
                                                    color: AppColors
                                                        .backgroundColor,
                                                    elevation: 0.0,
                                                    height: MediaQueryUtil
                                                            .screenHeight /
                                                        32.46,
                                                    minWidth: double.infinity,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .circular(MediaQueryUtil
                                                                  .screenWidth /
                                                              103),
                                                    ),
                                                    child: Text('Show all',
                                                        style: TextStyle(
                                                            fontSize: MediaQueryUtil
                                                                    .screenWidth /
                                                                34.33,
                                                            color: AppColors
                                                                .black60)))
                                              ]),
                                        SizedBox(
                                            height:
                                                MediaQueryUtil.screenHeight /
                                                    50),
                                        Text('Reviews',
                                            style: TextStyle(
                                                fontSize:
                                                    MediaQueryUtil.screenWidth /
                                                        17.16,
                                                color:
                                                    AppColors.primaryFontColor,
                                                fontFamily:
                                                    FontFamily.russoOne)),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              controller.comments.isNotEmpty
                                                  ? ListView.builder(
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemCount: 2,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return GestureDetector(
                                                            onTap: () =>
                                                                Get.toNamed(
                                                                    Routes
                                                                        .storeReviews,
                                                                    arguments: {
                                                                      "id": store
                                                                          .id
                                                                          .toString()
                                                                    }),
                                                            child: CommentWidget(
                                                                comment: controller
                                                                        .comments[
                                                                    index]));
                                                      })
                                                  : Center(
                                                      child: Text('No Reviews!',
                                                          style: TextStyle(
                                                              fontSize:
                                                                  MediaQueryUtil
                                                                          .screenWidth /
                                                                      25.75,
                                                              color: AppColors
                                                                  .black60))),
                                              MaterialButton(
                                                  onPressed: () => Get.toNamed(
                                                          Routes.storeReviews,
                                                          arguments: {
                                                            "id": store.id
                                                                .toString()
                                                          }),
                                                  color:
                                                      AppColors.backgroundColor,
                                                  elevation: 0.0,
                                                  height: MediaQueryUtil
                                                          .screenHeight /
                                                      32.46,
                                                  minWidth: double.infinity,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      MediaQueryUtil
                                                              .screenWidth /
                                                          103,
                                                    ),
                                                  ),
                                                  child: Text(
                                                      controller.comments.isNotEmpty
                                                          ? 'Show all'
                                                          : 'Add Review',
                                                      style: TextStyle(
                                                          fontSize: MediaQueryUtil
                                                                  .screenWidth /
                                                              34.33,
                                                          color: AppColors.black60))),
                                              SizedBox(
                                                  height: MediaQueryUtil
                                                          .screenHeight /
                                                      26.375),
                                              Text('Rate this store!',
                                                  style: TextStyle(
                                                      fontSize: MediaQueryUtil
                                                              .screenWidth /
                                                          17.16,
                                                      color: AppColors
                                                          .primaryFontColor,
                                                      fontFamily:
                                                          FontFamily.russoOne)),
                                              RatingWidget(
                                                  userRate: store.userRate)
                                            ])
                                      ]))),
                          Padding(
                              padding: EdgeInsets.only(
                                  right: MediaQueryUtil.screenWidth / 20.6,
                                  left: MediaQueryUtil.screenWidth / 20.6,
                                  bottom: MediaQueryUtil.screenHeight / 100),
                              child: Row(children: [
                                Expanded(
                                    child: MaterialButton(
                                        onPressed: controller.callStore,
                                        height:
                                            MediaQueryUtil.screenHeight / 20.58,
                                        color: AppColors.primaryOrangeColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                MediaQueryUtil.screenWidth /
                                                    51.5)),
                                        child: Text('Call store',
                                            style: TextStyle(
                                                fontSize:
                                                    MediaQueryUtil.screenWidth /
                                                        25.75,
                                                color: AppColors.white)))),
                                SizedBox(
                                    width: MediaQueryUtil.screenWidth / 25.75),
                                FavIcon(id: id)
                              ]))
                        ]));
                  })
            ]);
          },
        ));
  }
}
