import 'dart:ui';

import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/account/controller/accountcontroller.dart';
import 'package:bazaartech/view/productdetails/controller/commentscontroller.dart';
import 'package:bazaartech/view/productdetails/widgets/addcomment.dart';
import 'package:bazaartech/widget/customappbarwithback.dart';
import 'package:bazaartech/widget/customprogressindicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductComments extends StatelessWidget {
  final String id;
  const ProductComments({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    Get.put(CommentsController(id));
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CustomAppBarWithBack(text: 'Comments'),
      body: Column(
        children: [
          GetBuilder<CommentsController>(
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
                                  GestureDetector(
                                    onLongPress: () {
                                      if (Get.find<AccountController>()
                                              .user
                                              .value!
                                              .id ==
                                          comment.userId) {
                                        showDialog(
                                          context: Get.context!,
                                          barrierColor: Colors.black
                                              .withValues(alpha: 0.3),
                                          builder: (context) {
                                            return BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaX: 5, sigmaY: 5),
                                              child: AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                title: Text(
                                                  "Choose an action",
                                                  style: TextStyle(
                                                      fontSize: MediaQueryUtil
                                                              .screenWidth /
                                                          25.75,
                                                      color: AppColors
                                                          .primaryFontColor),
                                                ),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    ListTile(
                                                      leading: const Icon(
                                                          Icons.edit,
                                                          color: Colors.blue),
                                                      title: Text(
                                                          "Edit Comment",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  MediaQueryUtil
                                                                          .screenWidth /
                                                                      25.75,
                                                              color: AppColors
                                                                  .primaryFontColor)),
                                                      onTap: () {
                                                        Get.back();
                                                        controller.startEditing(
                                                            comment);
                                                      },
                                                    ),
                                                    ListTile(
                                                      leading: const Icon(
                                                          Icons.delete,
                                                          color: AppColors
                                                              .slidableDeleteColor),
                                                      title: Text(
                                                          "Delete Comment",
                                                          style: TextStyle(
                                                              fontSize:
                                                                  MediaQueryUtil
                                                                          .screenWidth /
                                                                      25.75,
                                                              color: AppColors
                                                                  .primaryFontColor)),
                                                      onTap: () {
                                                        Get.defaultDialog(
                                                            title:
                                                                'Delete comment',
                                                            titleStyle: const TextStyle(
                                                                color: AppColors
                                                                    .primaryFontColor),
                                                            middleText:
                                                                'You sure you want to delete your comment?',
                                                            middleTextStyle:
                                                                const TextStyle(
                                                                    color: AppColors
                                                                        .primaryOrangeColor),
                                                            backgroundColor:
                                                                AppColors.white,
                                                            buttonColor: AppColors
                                                                .primaryOrangeColor,
                                                            cancelTextColor:
                                                                AppColors
                                                                    .primaryFontColor,
                                                            textConfirm:
                                                                'Delete!',
                                                            textCancel:
                                                                'Cancel',
                                                            confirmTextColor:
                                                                AppColors.white,
                                                            onConfirm:
                                                                () async {
                                                              Get.back();
                                                              Get.back();
                                                              controller
                                                                  .deleteComment(
                                                                      comment.id
                                                                          .toString());
                                                            },
                                                            onCancel: () =>
                                                                Get.back());
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    },
                                    child: Container(
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
                                                              width: double
                                                                  .infinity,
                                                              height: double
                                                                  .infinity,
                                                              placeholder: (context,
                                                                      url) =>
                                                                  const Center(
                                                                child: CircularProgressIndicator(
                                                                    strokeWidth:
                                                                        2),
                                                              ),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  Image.asset(
                                                                AppImages
                                                                    .profilephoto,
                                                                fit: BoxFit
                                                                    .cover,
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
                                                              width: double
                                                                  .infinity,
                                                              height: double
                                                                  .infinity,
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
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    '${comment.rating.toString()} ',
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
                          'No comments yet',
                          style: TextStyle(color: AppColors.black60),
                        ),
                      ),
                    );
            },
          ),
          const AddComment(),
        ],
      ),
    );
  }
}
