import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/storedetails/controller/storedetailscontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddStoreReview extends StatelessWidget {
  const AddStoreReview({super.key});

  @override
  Widget build(BuildContext context) {
    StoreDetailsController controller = Get.find<StoreDetailsController>();
    return Obx(() {
      final isLoading = controller.isLoadingAddingReview.value;
      final isReviewEmpty = controller.reviewText.isEmpty;

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
                      controller: controller.reviewController,
                      keyboardType: TextInputType.multiline,
                      minLines: 1,
                      maxLines: 3,
                      enabled: !isLoading,
                      onChanged: (value) {
                        controller.reviewText.value = value.trim();
                      },
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 16),
                        border: InputBorder.none,
                        hintText: 'Write a review...',
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
                    onTap: isReviewEmpty || isLoading
                        ? null
                        : () async {
                            await controller.addReview(
                              controller.store.value!,
                              controller.reviewText.value,
                            );
                            if (!isLoading) {
                              controller.reviewController.clear();
                            }
                          },
                    child: Image.asset(
                      AppImages.addCommentIcon,
                      width: MediaQueryUtil.screenWidth / 17.16,
                      color: isReviewEmpty || isLoading
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
