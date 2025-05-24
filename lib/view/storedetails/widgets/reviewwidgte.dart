import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/storedetails/widgets/reviewimage.dart';
import 'package:flutter/material.dart';

class ReviewWidget extends StatelessWidget {
  final String profilePhoto;
  final String name;
  final int rating;
  final String review;

  const ReviewWidget({
    super.key,
    required this.profilePhoto,
    required this.name,
    required this.rating,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    MediaQueryUtil.init(context);
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQueryUtil.screenHeight / 52.75),
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
          Text(
            review,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: MediaQueryUtil.screenWidth / 25.75,
                color: AppColors.black60),
          )
        ],
      ),
    );
  }
}
