import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/storedetails/controller/storedetailscontroller.dart';
import 'package:bazaartech/view/storedetails/widgets/reviewimage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewStoreWidget extends StatelessWidget {
  final int index;
  final String profilePhoto;
  final String name;
  final int rating;
  final String review;
  final int likes;
  final bool isLiked;

  const ReviewStoreWidget({
    super.key,
    required this.profilePhoto,
    required this.name,
    required this.rating,
    required this.review,
    required this.index,
    required this.likes,
    required this.isLiked,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StoreDetailsController>();
    MediaQueryUtil.init(context);
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQueryUtil.screenHeight / 105.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(children: [
                  buildReviewImage(profilePhoto),
                  SizedBox(width: MediaQueryUtil.screenWidth / 68.66),
                  Text(name,
                      style: TextStyle(
                          fontSize: MediaQueryUtil.screenWidth / 25.75,
                          color: AppColors.primaryFontColor))
                ]),
                Row(children: [
                  Text('${rating.toString()} ',
                      style: TextStyle(
                          fontSize: MediaQueryUtil.screenWidth / 25.75,
                          color: AppColors.primaryFontColor)),
                  Image.asset(AppImages.starIcon, width: 16)
                ])
              ]),
          SizedBox(height: MediaQueryUtil.screenHeight / 140.6),
          Text(review,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: MediaQueryUtil.screenWidth / 25.75,
                  color: AppColors.black60)),
          Row(children: [
            IconButton(
                onPressed: () {
                  controller.toggleLike(index);
                  controller.update(['reviewstore_$index']);
                },
                icon: Image.asset(
                  isLiked ? AppImages.filledHeart : AppImages.heart,
                  color: AppColors.primaryOrangeColor,
                  width: MediaQueryUtil.screenWidth / 25.75,
                )),
            if (likes != 0)
              Text(
                likes > 1 ? '$likes likes' : '$likes like',
                style: TextStyle(
                    fontSize: MediaQueryUtil.screenWidth / 29.42,
                    color: AppColors.black60),
              )
          ])
        ],
      ),
    );
  }
}
