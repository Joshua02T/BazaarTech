import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/search/controller/filtersearchcontroller.dart';
import 'package:flutter/material.dart';

class DefaultAndSave extends StatelessWidget {
  final FilterSearchController controller;
  final void Function() onPressed;
  const DefaultAndSave(
      {super.key, required this.controller, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQueryUtil.screenWidth / 20.6,
          right: MediaQueryUtil.screenWidth / 20.6,
          bottom: MediaQueryUtil.screenHeight / 26.375,
          top: MediaQueryUtil.screenHeight / 26.375),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MaterialButton(
            onPressed: onPressed,
            color: AppColors.white,
            height: MediaQueryUtil.screenHeight / 19.18,
            minWidth: MediaQueryUtil.screenWidth / 2.42,
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(MediaQueryUtil.screenWidth / 51.5)),
            child: Text(
              'Re-set Default',
              style: TextStyle(
                  color: AppColors.primaryFontColor,
                  fontSize: MediaQueryUtil.screenWidth / 25.75),
            ),
          ),
          MaterialButton(
            onPressed: () {
              if (controller.filterKey.currentState!.validate()) {}
            },
            color: AppColors.primaryOrangeColor,
            height: MediaQueryUtil.screenHeight / 19.18,
            minWidth: MediaQueryUtil.screenWidth / 2.42,
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(MediaQueryUtil.screenWidth / 51.5)),
            child: Text(
              'Save',
              style: TextStyle(
                  color: AppColors.white,
                  fontSize: MediaQueryUtil.screenWidth / 25.75),
            ),
          ),
        ],
      ),
    );
  }
}
