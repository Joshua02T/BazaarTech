import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/model/commentmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {
  final Comment comment;

  const CommentWidget({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
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
                  CircleAvatar(
                    radius: MediaQueryUtil.screenWidth / 20.6,
                    backgroundColor: Colors.grey.shade200,
                    child: ClipOval(
                      child: comment.profilePhoto != null
                          ? CachedNetworkImage(
                              imageUrl: comment.profilePhoto!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              placeholder: (context, url) => const Center(
                                child:
                                    CircularProgressIndicator(strokeWidth: 2),
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                AppImages.profilephoto,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            )
                          : Image.asset(
                              AppImages.profilephoto,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                    ),
                  ),
                  SizedBox(width: MediaQueryUtil.screenWidth / 68.66),
                  Text(comment.name,
                      style: TextStyle(
                          fontSize: MediaQueryUtil.screenWidth / 25.75,
                          color: AppColors.primaryFontColor))
                ]),
                Row(children: [
                  Text('${comment.rating.toString()} ',
                      style: TextStyle(
                          fontSize: MediaQueryUtil.screenWidth / 25.75,
                          color: AppColors.primaryFontColor)),
                  Image.asset(AppImages.starIcon, width: 16)
                ])
              ]),
          SizedBox(height: MediaQueryUtil.screenHeight / 140.6),
          Text(
            comment.comment,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: MediaQueryUtil.screenWidth / 25.75,
                color: AppColors.black60),
          ),
          SizedBox(height: MediaQueryUtil.screenHeight / 140.6),
        ],
      ),
    );
  }
}
