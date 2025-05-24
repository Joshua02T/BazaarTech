import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:flutter/material.dart';

class SearchHistoryReco extends StatelessWidget {
  final String title;
  const SearchHistoryReco({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    MediaQueryUtil.init(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Image.asset(
                AppImages.bazaarClock,
                width: MediaQueryUtil.screenWidth / 25.75,
              ),
              SizedBox(width: MediaQueryUtil.screenWidth / 34.33),
              Text(
                title,
                style: TextStyle(
                    fontSize: MediaQueryUtil.screenWidth / 25.75,
                    color: AppColors.primaryFontColor),
              )
            ]),
            Image.asset(
              AppImages.searchHistoryVector,
              width: MediaQueryUtil.screenWidth / 25.75,
            )
          ],
        ),
        SizedBox(height: MediaQueryUtil.screenHeight / 84.4),
        const Divider(color: AppColors.borderLightGrey),
        SizedBox(height: 8)
      ],
    );
  }
}
