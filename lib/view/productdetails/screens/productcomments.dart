import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/productdetails/controller/productdetailscontroller.dart';
import 'package:bazaartech/view/productdetails/widgets/addcomment.dart';
import 'package:bazaartech/view/productdetails/widgets/commentimage.dart';
import 'package:bazaartech/widget/customappbarwithback.dart';
import 'package:bazaartech/widget/customprogressindicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductComments extends StatelessWidget {
  const ProductComments({super.key});

  @override
  Widget build(BuildContext context) {
    ProductDetailsController controller = Get.find<ProductDetailsController>();
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CustomAppBarWithBack(text: 'Comments'),
      body: Column(
        children: [
          Obx(() {
            if (controller.isLoadingFetching.value) {
              return const Expanded(child: CustomProgressIndicator());
            }

            final comments = controller.comments;

            return comments.isNotEmpty
                ? Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQueryUtil.screenWidth / 20.6,
                        vertical: MediaQueryUtil.screenHeight / 70,
                      ),
                      child: RefreshIndicator(
                        onRefresh: () => controller
                            .fetchProduct(controller.product.value!.id),
                        child: ListView.builder(
                          clipBehavior: Clip.none,
                          itemCount: comments.length,
                          itemBuilder: (context, index) {
                            return GetBuilder<ProductDetailsController>(
                              id: 'comment_$index',
                              builder: (_) {
                                final comment = controller.comments[index];
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
                                                  buildCommentImage(
                                                      comment.profilePhoto),
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
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    '${comment.rating.toInt()} ',
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
                                            height:
                                                MediaQueryUtil.screenHeight /
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
                                              controller.toggleLike(index);
                                              controller
                                                  .update(['comment_$index']);
                                            },
                                            icon: Image.asset(
                                              comment.isLiked
                                                  ? AppImages.filledHeart
                                                  : AppImages.heart,
                                              width:
                                                  MediaQueryUtil.screenWidth /
                                                      25.75,
                                              color:
                                                  AppColors.primaryOrangeColor,
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
                            );
                          },
                        ),
                      ),
                    ),
                  )
                : const Expanded(
                    child: Center(
                      child: Text(
                        'No comments yet',
                        style: TextStyle(color: AppColors.black60),
                      ),
                    ),
                  );
          }),
          const AddComment(),
        ],
      ),
    );
  }
}
