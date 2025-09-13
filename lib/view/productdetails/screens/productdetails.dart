import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/const_data/font_family.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/core/service/my_service.dart';
import 'package:bazaartech/core/service/routes.dart';
import 'package:bazaartech/view/cart/controller/cartcontroller.dart';
import 'package:bazaartech/view/home/controller/home_controller.dart';
import 'package:bazaartech/view/productdetails/controller/productdetailscontroller.dart';
import 'package:bazaartech/view/productdetails/screens/ratingwidget.dart';
import 'package:bazaartech/widget/commentwidget.dart';
import 'package:bazaartech/widget/customdetailsfavicon.dart';
import 'package:bazaartech/widget/customdetailsiconback.dart';
import 'package:bazaartech/widget/customprogressindicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetails extends StatelessWidget {
  final String id;
  const ProductDetails({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    Get.put(ProductDetailsController(id));
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: GetBuilder<ProductDetailsController>(
          builder: (controller) {
            if (controller.isLoadingFetching) {
              return const Center(child: CustomProgressIndicator());
            }
            if (controller.product == null) {
              return Center(
                  child: Text('Product not found',
                      style: TextStyle(
                          fontSize: MediaQueryUtil.screenWidth / 25.75,
                          color: AppColors.black60)));
            }
            final product = controller.product!;
            return Stack(children: [
              GestureDetector(
                onTap: () => showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                          backgroundColor: Colors.transparent,
                          child: InteractiveViewer(
                            child: CachedNetworkImage(
                              imageUrl: product.image,
                              placeholder: (context, url) => const Center(
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                AppImages.productPhoto,
                              ),
                            ),
                          ));
                    }),
                child: CachedNetworkImage(
                  imageUrl: product.image,
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
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const CustomDetailsIconBack(),
                if (product.status != 'NONE')
                  Padding(
                      padding: EdgeInsets.only(
                          top: MediaQueryUtil.screenHeight / 25),
                      child: Container(
                          width: MediaQueryUtil.screenWidth / 2.76,
                          height: MediaQueryUtil.screenHeight / 25.57,
                          decoration: const BoxDecoration(
                              color: AppColors.primaryOrangeColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  topLeft: Radius.circular(8))),
                          child: Center(
                              child: Text(product.status,
                                  style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: MediaQueryUtil.screenWidth /
                                          25.75)))))
              ]),
              DraggableScrollableSheet(
                initialChildSize: MediaQueryUtil.screenHeight / 1298.46,
                minChildSize: MediaQueryUtil.screenHeight / 1383.6,
                maxChildSize: MediaQueryUtil.screenHeight / 992.94,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(
                                MediaQueryUtil.screenWidth / 9.15),
                          ),
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
                                    left: MediaQueryUtil.screenWidth / 20.6,
                                    right: MediaQueryUtil.screenWidth / 20.6,
                                    top: MediaQueryUtil.screenHeight / 120,
                                    bottom: MediaQueryUtil.screenHeight / 42.2),
                                child: ListView(
                                    controller: scrollController,
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(product.name,
                                                style: TextStyle(
                                                    fontSize: MediaQueryUtil
                                                            .screenWidth /
                                                        17.16,
                                                    color: AppColors
                                                        .primaryFontColor,
                                                    fontFamily:
                                                        FontFamily.russoOne)),
                                            RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                  text: '\$ ',
                                                  style: TextStyle(
                                                      fontSize: MediaQueryUtil
                                                              .screenWidth /
                                                          25.75,
                                                      color: AppColors
                                                          .primaryOrangeColor,
                                                      fontFamily:
                                                          FontFamily.russoOne)),
                                              TextSpan(
                                                  text: '${product.price} ',
                                                  style: TextStyle(
                                                      fontSize: MediaQueryUtil
                                                              .screenWidth /
                                                          17.16,
                                                      color: AppColors
                                                          .primaryFontColor,
                                                      fontFamily:
                                                          FontFamily.russoOne)),
                                              if (product.oldPrice != 0)
                                                TextSpan(
                                                    text:
                                                        '${controller.product!.oldPrice}',
                                                    style: TextStyle(
                                                        fontSize: MediaQueryUtil
                                                                .screenWidth /
                                                            34.33,
                                                        color: AppColors
                                                            .discountFontColor,
                                                        fontFamily:
                                                            FontFamily.russoOne,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        decorationColor: AppColors
                                                            .discountFontColor,
                                                        decorationThickness: 2))
                                            ]))
                                          ]),
                                      Text(product.markerName,
                                          style: TextStyle(
                                              fontSize:
                                                  MediaQueryUtil.screenWidth /
                                                      25.75,
                                              color: AppColors.black60)),
                                      SizedBox(
                                          height: MediaQueryUtil.screenHeight /
                                              52.75),
                                      Text(product.details,
                                          style: TextStyle(
                                              fontSize:
                                                  MediaQueryUtil.screenWidth /
                                                      25.75,
                                              color: AppColors.black60)),
                                      SizedBox(
                                          height: MediaQueryUtil.screenHeight /
                                              26.375),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Ratings',
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
                                                      index < product.rating
                                                          ? AppImages.starIcon
                                                          : AppImages
                                                              .unFilledStarIcon,
                                                      width: MediaQueryUtil
                                                              .screenWidth /
                                                          17.16));
                                            }))
                                          ]),
                                      SizedBox(
                                          height: MediaQueryUtil.screenHeight /
                                              40.19),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          if (controller.comments.isNotEmpty)
                                            ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: 2,
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: () => Get.toNamed(
                                                      Routes.productComments,
                                                      arguments: {
                                                        "id": product.id
                                                            .toString()
                                                      }),
                                                  child: CommentWidget(
                                                      comment: controller
                                                          .comments[index]),
                                                );
                                              },
                                            ),
                                          if (!controller.comments.isNotEmpty)
                                            Center(
                                              child: Text(
                                                'No Comments!',
                                                style: TextStyle(
                                                  fontSize: MediaQueryUtil
                                                          .screenWidth /
                                                      25.75,
                                                  color: AppColors.black60,
                                                ),
                                              ),
                                            ),
                                          MaterialButton(
                                            onPressed: () {
                                              Get.toNamed(
                                                  Routes.productComments,
                                                  arguments: {
                                                    "id": product.id.toString()
                                                  });
                                            },
                                            color: AppColors.backgroundColor,
                                            elevation: 0.0,
                                            height:
                                                MediaQueryUtil.screenHeight /
                                                    32.46,
                                            minWidth: double.infinity,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                MediaQueryUtil.screenWidth /
                                                    103,
                                              ),
                                            ),
                                            child: Text(
                                              controller.comments.isNotEmpty
                                                  ? 'Show all'
                                                  : 'Add Comment',
                                              style: TextStyle(
                                                fontSize:
                                                    MediaQueryUtil.screenWidth /
                                                        34.33,
                                                color: AppColors.black60,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              height:
                                                  MediaQueryUtil.screenHeight /
                                                      26.375),
                                          Text('Rate this product!',
                                              style: TextStyle(
                                                  fontSize: MediaQueryUtil
                                                          .screenWidth /
                                                      17.16,
                                                  color: AppColors
                                                      .primaryFontColor,
                                                  fontFamily:
                                                      FontFamily.russoOne)),
                                          RatingWidget(
                                              userRate: product.userRate)
                                        ],
                                      )
                                    ]))),
                        Padding(
                            padding: EdgeInsets.only(
                                right: MediaQueryUtil.screenWidth / 20.6,
                                left: MediaQueryUtil.screenWidth / 20.6,
                                bottom: MediaQueryUtil.screenHeight / 100),
                            child: Row(children: [
                              Expanded(
                                  child: MaterialButton(
                                      onPressed: () {
                                        if (controller.product != null) {
                                          Get.find<HomeController>().addToCart(
                                              controller.product!.id,
                                              isFromBazaar:
                                                  Get.find<MyService>()
                                                      .isFromBazaar);
                                        }
                                      },
                                      height:
                                          MediaQueryUtil.screenHeight / 20.58,
                                      color: AppColors.primaryOrangeColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              MediaQueryUtil.screenWidth /
                                                  51.5)),
                                      child: Text('Add item to cart',
                                          style: TextStyle(
                                              fontSize:
                                                  MediaQueryUtil.screenWidth /
                                                      25.75,
                                              color: AppColors.white)))),
                              SizedBox(
                                  width: MediaQueryUtil.screenWidth / 25.75),
                              FavIcon(id: id),
                            ]))
                      ]));
                },
              )
            ]);
          },
        ));
  }
}
