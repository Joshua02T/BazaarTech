import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/storedetails/controller/storedetailscontroller.dart';
import 'package:bazaartech/view/storedetails/widgets/addstorereview.dart';
import 'package:bazaartech/view/storedetails/widgets/reviewimage.dart';
import 'package:bazaartech/widget/customappbarwithback.dart';
import 'package:bazaartech/widget/customprogressindicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreReviews extends StatelessWidget {
  const StoreReviews({super.key});

  @override
  Widget build(BuildContext context) {
    StoreDetailsController controller = Get.find<StoreDetailsController>();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CustomAppBarWithBack(text: 'Reviews'),
      body: Column(
        children: [
          Obx(() {
            final currentStore = controller.store.value;
            if (currentStore == null) {
              return const Expanded(child: CustomProgressIndicator());
            }
            if (controller.isLoadingFetching.value) {
              return const Expanded(child: CustomProgressIndicator());
            }

            return currentStore.reviews.isNotEmpty
                ? Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQueryUtil.screenWidth / 20.6,
                        vertical: MediaQueryUtil.screenHeight / 70,
                      ),
                      child: RefreshIndicator(
                        onRefresh: () =>
                            controller.fetchStore(controller.store.value!.id),
                        child: ListView.builder(
                          clipBehavior: Clip.none,
                          itemCount: currentStore.reviews.length,
                          itemBuilder: (context, index) {
                            final review = currentStore.reviews[index];
                            return Container(
                              margin: EdgeInsets.only(
                                bottom: MediaQueryUtil.screenHeight / 52.75,
                              ),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(children: [
                                        buildReviewImage(review.profilePhoto),
                                        SizedBox(
                                            width: MediaQueryUtil.screenWidth /
                                                68.66),
                                        Text(
                                          review.name,
                                          style: TextStyle(
                                            fontSize:
                                                MediaQueryUtil.screenWidth /
                                                    25.75,
                                            color: AppColors.primaryFontColor,
                                          ),
                                        ),
                                      ]),
                                      Row(children: [
                                        Text(
                                          '${review.rating.toInt().toString()} ',
                                          style: TextStyle(
                                            fontSize:
                                                MediaQueryUtil.screenWidth /
                                                    25.75,
                                            color: AppColors.primaryFontColor,
                                          ),
                                        ),
                                        Image.asset(AppImages.starIcon,
                                            width: 16),
                                      ]),
                                    ],
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQueryUtil.screenHeight / 140.6),
                                  Text(
                                    review.review,
                                    style: TextStyle(
                                      fontSize:
                                          MediaQueryUtil.screenWidth / 25.75,
                                      color: AppColors.black60,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: Center(
                      child: Text(
                        'No reviews yet',
                        style: TextStyle(
                          fontSize: MediaQueryUtil.screenWidth / 25.75,
                          color: AppColors.black60,
                        ),
                      ),
                    ),
                  );
          }),
          const AddStoreReview(),
        ],
      ),
    );
  }
}
