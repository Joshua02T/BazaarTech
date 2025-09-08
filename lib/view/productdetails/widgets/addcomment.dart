import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/productdetails/controller/commentscontroller.dart';
import 'package:bazaartech/view/productdetails/controller/productdetailscontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddComment extends StatelessWidget {
  const AddComment({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommentsController>(builder: (controller) {
      final isLoading = controller.isLoadingAddingComment;
      final text = controller.commentController.text.trim();
      final isCommentEmpty = text.isEmpty;

      return ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(MediaQueryUtil.screenWidth / 13.73),
          topRight: Radius.circular(MediaQueryUtil.screenWidth / 13.73),
        ),
        child: Container(
          color: AppColors.white,
          child: Padding(
            padding: EdgeInsets.only(
              left: MediaQueryUtil.screenWidth / 27.46,
              top: MediaQueryUtil.screenHeight / 52.75,
              bottom: MediaQueryUtil.screenHeight / 52.75,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.circular(
                        MediaQueryUtil.screenWidth / 31.69,
                      ),
                    ),
                    child: TextFormField(
                      controller: controller.commentController,
                      keyboardType: TextInputType.multiline,
                      focusNode: controller.commentFocusNode,
                      minLines: 1,
                      maxLines: 3,
                      onChanged: (_) => controller.update(),
                      enabled: !isLoading,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 16,
                        ),
                        border: InputBorder.none,
                        hintText: 'Write a comment...',
                        hintStyle: const TextStyle(
                          color: AppColors.black70,
                          fontSize: 12,
                        ),
                        suffixIcon: isLoading
                            ? Padding(
                                padding: EdgeInsets.all(
                                  MediaQueryUtil.screenWidth / 206,
                                ),
                                child: const CircularProgressIndicator(
                                  strokeWidth: 1,
                                  color: AppColors.primaryFontColor,
                                ),
                              )
                            : null,
                      ),
                      style: TextStyle(
                        fontSize: MediaQueryUtil.screenWidth / 34.33,
                        color: AppColors.primaryFontColor,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQueryUtil.screenWidth / 54.92,
                  ),
                  child: GestureDetector(
                    onTap: isCommentEmpty || isLoading
                        ? null
                        : () async {
                            if (controller.isEditing &&
                                controller.editingCommentId != null) {
                              await controller.editComment(
                                controller.editingCommentId.toString(),
                                text,
                                Get.find<ProductDetailsController>()
                                    .rating
                                    .toString(),
                              );
                            } else {
                              await controller.addComment(
                                Get.find<ProductDetailsController>()
                                    .product!
                                    .id
                                    .toString(),
                                text,
                                Get.find<ProductDetailsController>()
                                    .rating
                                    .toString(),
                              );
                            }
                          },
                    child: Image.asset(
                      AppImages.addCommentIcon,
                      width: MediaQueryUtil.screenWidth / 17.16,
                      color: isCommentEmpty || isLoading
                          ? Colors.grey
                          : AppColors.primaryFontColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
