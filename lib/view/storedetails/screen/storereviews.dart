import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/storedetails/controller/storecommentscontroller.dart';
import 'package:bazaartech/view/storedetails/controller/storedetailscontroller.dart';
import 'package:bazaartech/view/storedetails/widgets/addstorereview.dart';
import 'package:bazaartech/view/storedetails/widgets/reviewimage.dart';
import 'package:bazaartech/widget/customappbarwithback.dart';
import 'package:bazaartech/widget/customprogressindicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreReviews extends StatelessWidget {
  final String id;
  const StoreReviews({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    Get.put(StoreCommentsController(id));

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CustomAppBarWithBack(text: 'Reviews'),
      body: Column(
        children: [
          GetBuilder<StoreCommentsController>(
            builder: (controller) {
              if (controller.isLoadingFetchingComments) {
                return const Expanded(child: CustomProgressIndicator());
              }
              final comments = controller.allComments;
              return comments.isNotEmpty
                  ? Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQueryUtil.screenWidth / 20.6,
                          vertical: MediaQueryUtil.screenHeight / 70,
                        ),
                        child: RefreshIndicator(
                          onRefresh: () async =>
                              await controller.fetchCommentsById(id),
                          child: ListView.builder(
                            clipBehavior: Clip.none,
                            itemCount: controller.allComments.length,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final comment = controller.allComments[index];
                              return Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(
                                        MediaQueryUtil.screenWidth / 25.75),
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
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: MediaQueryUtil
                                                          .screenWidth /
                                                      20.6,
                                                  backgroundColor:
                                                      Colors.grey.shade200,
                                                  child: ClipOval(
                                                    child: comment
                                                                .profilePhoto !=
                                                            null
                                                        ? CachedNetworkImage(
                                                            imageUrl: comment
                                                                .profilePhoto!,
                                                            fit: BoxFit.cover,
                                                            width:
                                                                double.infinity,
                                                            height:
                                                                double.infinity,
                                                            placeholder:
                                                                (context,
                                                                        url) =>
                                                                    const Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                                      strokeWidth:
                                                                          2),
                                                            ),
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    Image.asset(
                                                              AppImages
                                                                  .profilephoto,
                                                              fit: BoxFit.cover,
                                                              width: double
                                                                  .infinity,
                                                              height: double
                                                                  .infinity,
                                                            ),
                                                          )
                                                        : Image.asset(
                                                            AppImages
                                                                .profilephoto,
                                                            fit: BoxFit.cover,
                                                            width:
                                                                double.infinity,
                                                            height:
                                                                double.infinity,
                                                          ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQueryUtil
                                                          .screenWidth /
                                                      68.66,
                                                ),
                                                Text(
                                                  ' ${comment.name}',
                                                  style: TextStyle(
                                                    fontSize: MediaQueryUtil
                                                            .screenWidth /
                                                        25.75,
                                                    color: AppColors
                                                        .primaryFontColor,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  comment.rating.toString(),
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
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: MediaQueryUtil.screenHeight /
                                              140.6,
                                        ),
                                        Text(
                                          comment.comment,
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
                                            controller.toggleLike(
                                                comment.id.toString());
                                          },
                                          icon: Image.asset(
                                            comment.isLiked == true
                                                ? AppImages.filledHeart
                                                : AppImages.heart,
                                            width: MediaQueryUtil.screenWidth /
                                                25.75,
                                            color: AppColors.primaryOrangeColor,
                                          )),
                                      if (comment.likes > 0)
                                        Text(
                                          comment.likes > 1
                                              ? '${comment.likes} likes'
                                              : '${comment.likes} like',
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
            },
          ),
          const AddStoreReview(),
        ],
      ),
      // Column(
      //   children: [
      //     Obx(() {
      //       if (controller.isLoadingFetching) {
      //         return const Expanded(child: CustomProgressIndicator());
      //       }

      //       final reviews = controller.reviews;

      //       return reviews.isNotEmpty
      //           ? Expanded(
      //               child: Padding(
      //                 padding: EdgeInsets.symmetric(
      //                   horizontal: MediaQueryUtil.screenWidth / 20.6,
      //                   vertical: MediaQueryUtil.screenHeight / 70,
      //                 ),
      //                 child: RefreshIndicator(
      //                   onRefresh: () async {
      //                     final store = controller.store.value;
      //                     if (store != null) {
      //                       //await controller.fetchStore(store.id);
      //                     }
      //                   },
      //                   child: ListView.builder(
      //                     clipBehavior: Clip.none,
      //                     itemCount: reviews.length,
      //                     itemBuilder: (context, index) {
      //                       return GetBuilder<StoreDetailsController>(
      //                         id: 'reviewstore_$index',
      //                         builder: (_) {
      //                           final review = controller.reviews[index];
      //                           return Column(
      //                             children: [
      //                               Container(
      //                                 padding: EdgeInsets.all(
      //                                   MediaQueryUtil.screenWidth / 25.75,
      //                                 ),
      //                                 decoration: BoxDecoration(
      //                                   color: AppColors.white,
      //                                   borderRadius: BorderRadius.circular(
      //                                     MediaQueryUtil.screenWidth / 51.5,
      //                                   ),
      //                                 ),
      //                                 child: Column(
      //                                   crossAxisAlignment:
      //                                       CrossAxisAlignment.start,
      //                                   children: [
      //                                     Row(
      //                                       mainAxisAlignment:
      //                                           MainAxisAlignment.spaceBetween,
      //                                       crossAxisAlignment:
      //                                           CrossAxisAlignment.center,
      //                                       children: [
      //                                         Row(children: [
      //                                           buildReviewImage(
      //                                               review.profilePhoto!),
      //                                           SizedBox(
      //                                               width: MediaQueryUtil
      //                                                       .screenWidth /
      //                                                   68.66),
      //                                           Text(
      //                                             review.name,
      //                                             style: TextStyle(
      //                                               fontSize: MediaQueryUtil
      //                                                       .screenWidth /
      //                                                   25.75,
      //                                               color: AppColors
      //                                                   .primaryFontColor,
      //                                               fontWeight: FontWeight.w600,
      //                                             ),
      //                                           ),
      //                                         ]),
      //                                         Row(children: [
      //                                           Text(
      //                                             '${review.rating.toInt()} ',
      //                                             style: TextStyle(
      //                                               fontSize: MediaQueryUtil
      //                                                       .screenWidth /
      //                                                   25.75,
      //                                               color: AppColors
      //                                                   .primaryFontColor,
      //                                             ),
      //                                           ),
      //                                           Image.asset(
      //                                             AppImages.starIcon,
      //                                             width: 16,
      //                                           ),
      //                                         ]),
      //                                       ],
      //                                     ),
      //                                     SizedBox(
      //                                         height:
      //                                             MediaQueryUtil.screenHeight /
      //                                                 140.6),
      //                                     Text(
      //                                       review.comment,
      //                                       style: TextStyle(
      //                                         fontSize:
      //                                             MediaQueryUtil.screenWidth /
      //                                                 25.75,
      //                                         color: AppColors.black60,
      //                                       ),
      //                                     ),
      //                                   ],
      //                                 ),
      //                               ),
      //                               Row(
      //                                 children: [
      //                                   IconButton(
      //                                     onPressed: () {
      //                                       controller.toggleLike(index);
      //                                       controller
      //                                           .update(['reviewstore_$index']);
      //                                     },
      //                                     icon: Image.asset(
      //                                       review.isLiked
      //                                           ? AppImages.filledHeart
      //                                           : AppImages.heart,
      //                                       width: MediaQueryUtil.screenWidth /
      //                                           25.75,
      //                                       color: AppColors.primaryOrangeColor,
      //                                     ),
      //                                   ),
      //                                   if (review.likes > 0)
      //                                     Text(
      //                                       review.likes > 1
      //                                           ? '${review.likes} likes'
      //                                           : '${review.likes} like',
      //                                       style: TextStyle(
      //                                         fontSize:
      //                                             MediaQueryUtil.screenWidth /
      //                                                 29.42,
      //                                         color: AppColors.black60,
      //                                       ),
      //                                     ),
      //                                 ],
      //                               ),
      //                               SizedBox(
      //                                   height:
      //                                       MediaQueryUtil.screenHeight / 70.33)
      //                             ],
      //                           );
      //                         },
      //                       );
      //                     },
      //                   ),
      //                 ),
      //               ),
      //             )
      //           : const Expanded(
      //               child: Center(
      //                 child: Text(
      //                   'No reviews yet',
      //                   style: TextStyle(color: AppColors.black60),
      //                 ),
      //               ),
      //             );
      //     }),
      //     const AddStoreReview(),
      //   ],
      // ),
    );
  }
}
