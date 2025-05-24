import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/productdetails/controller/productdetailscontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddComment extends StatelessWidget {
  const AddComment({super.key});

  @override
  Widget build(BuildContext context) {
    ProductDetailsController controller = Get.find<ProductDetailsController>();
    return Obx(() {
      final isLoading = controller.isLoadingAddingComment.value;
      final isCommentEmpty = controller.commentText.isEmpty;

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
                          MediaQueryUtil.screenWidth / 31.69),
                    ),
                    child: TextFormField(
                      controller: controller.commentController,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 3,
                      enabled: !isLoading,
                      onChanged: (value) {
                        controller.commentText.value = value.trim();
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                        border: InputBorder.none,
                        hintText: 'Write a comment...',
                        hintStyle: const TextStyle(
                            color: AppColors.black70, fontSize: 12),
                        suffixIcon: isLoading
                            ? Padding(
                                padding: EdgeInsets.all(
                                    MediaQueryUtil.screenWidth / 206),
                                child: const CircularProgressIndicator(
                                    strokeWidth: 1,
                                    color: AppColors.primaryFontColor),
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
                      horizontal: MediaQueryUtil.screenWidth / 54.92),
                  child: GestureDetector(
                    onTap: isCommentEmpty || isLoading
                        ? null
                        : () async {
                            await controller.addComment(
                              controller.product.value!,
                              controller.commentText.value,
                            );
                            if (!isLoading) {
                              controller.commentController.clear();
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
