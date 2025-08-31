import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/bazaardetails/controller/bazaardetailscontroller.dart';
import 'package:bazaartech/view/bazaardetails/widgets/addbazaarreview.dart';
import 'package:bazaartech/view/storedetails/widgets/reviewimage.dart';
import 'package:bazaartech/widget/customappbarwithback.dart';
import 'package:bazaartech/widget/customprogressindicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BazaarReviews extends StatelessWidget {
  const BazaarReviews({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BazaarDetailsController>();

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CustomAppBarWithBack(text: 'Reviews'),
      body: Column(
        children: [
          Obx(() {
            if (controller.isLoadingFetching.value) {
              return const Expanded(child: CustomProgressIndicator());
            }

            final reviews = controller.reviews;

            return reviews.isNotEmpty
                ? Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQueryUtil.screenWidth / 20.6,
                        vertical: MediaQueryUtil.screenHeight / 70,
                      ),
                      child: RefreshIndicator(
                        onRefresh: () async {
                          final bazaar = controller.bazaar.value;
                          if (bazaar != null) {
                            await controller.fetchBazaar(bazaar.id);
                          }
                        },
                        child: ListView.builder(
                          clipBehavior: Clip.none,
                          itemCount: reviews.length,
                          itemBuilder: (context, index) {
                            return GetBuilder<BazaarDetailsController>(
                              id: 'reviewbazaar_$index',
                              builder: (_) {
                                final review = controller.reviews[index];
                                return Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(
                                        MediaQueryUtil.screenWidth / 25.75,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(
                                          MediaQueryUtil.screenWidth / 51.5,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(children: [
                                                buildReviewImage(
                                                    review.profilePhoto),
                                                SizedBox(
                                                    width: MediaQueryUtil
                                                            .screenWidth /
                                                        68.66),
                                                Text(
                                                  review.name,
                                                  style: TextStyle(
                                                    fontSize: MediaQueryUtil
                                                            .screenWidth /
                                                        25.75,
                                                    color: AppColors
                                                        .primaryFontColor,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ]),
                                              Row(children: [
                                                Text(
                                                  '${review.rating.toInt()} ',
                                                  style: TextStyle(
                                                    fontSize: MediaQueryUtil
                                                            .screenWidth /
                                                        25.75,
                                                    color: AppColors
                                                        .primaryFontColor,
                                                  ),
                                                ),
                                                Image.asset(
                                                  AppImages.starIcon,
                                                  width: 16,
                                                ),
                                              ]),
                                            ],
                                          ),
                                          SizedBox(
                                              height:
                                                  MediaQueryUtil.screenHeight /
                                                      140.6),
                                          Text(
                                            review.review,
                                            style: TextStyle(
                                              fontSize:
                                                  MediaQueryUtil.screenWidth /
                                                      25.75,
                                              color: AppColors.black60,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            controller.toggleLike(index);
                                            controller.update(
                                                ['reviewbazaar_$index']);
                                          },
                                          icon: Image.asset(
                                            review.isLiked
                                                ? AppImages.filledHeart
                                                : AppImages.heart,
                                            width: MediaQueryUtil.screenWidth /
                                                25.75,
                                            color: AppColors.primaryOrangeColor,
                                          ),
                                        ),
                                        if (review.likes > 0)
                                          Text(
                                            review.likes > 1
                                                ? '${review.likes} likes'
                                                : '${review.likes} like',
                                            style: TextStyle(
                                              fontSize:
                                                  MediaQueryUtil.screenWidth /
                                                      29.42,
                                              color: AppColors.black60,
                                            ),
                                          ),
                                      ],
                                    ),
                                    SizedBox(
                                        height:
                                            MediaQueryUtil.screenHeight / 70.33)
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  )
                : const Expanded(
                    child: Center(
                      child: Text(
                        'No reviews yet',
                        style: TextStyle(color: AppColors.black60),
                      ),
                    ),
                  );
          }),
          const AddBazaarReview(),
        ],
      ),
    );
  }
}
