import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/search/controller/bazaarfiltercontroller.dart';
import 'package:bazaartech/view/search/controller/productfilercontroller.dart';
import 'package:bazaartech/view/search/controller/storefiltercontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetDefaultButton extends StatelessWidget {
  final String controllerKind;
  const ResetDefaultButton({super.key, required this.controllerKind});

  @override
  Widget build(BuildContext context) {
    late dynamic controller;
    if (controllerKind == "product") {
      controller = Get.find<ProductFilterController>();
    } else if (controllerKind == "store") {
      controller = Get.find<StoreFilterController>();
    } else {
      controller = Get.find<BazaarFilterController>();
    }

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQueryUtil.screenHeight / 40),
      child: MaterialButton(
        onPressed: () {
          controllerKind == "product"
              ? controller.resetDefaultsProductFilter()
              : controllerKind == "store"
                  ? controller.resetDefaultsStoreFilter()
                  : controller.resetDefaultsBazaarFilter();
        },
        color: AppColors.primaryOrangeColor,
        height: MediaQueryUtil.screenHeight / 19.18,
        minWidth: MediaQueryUtil.screenWidth / 2.42,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(MediaQueryUtil.screenWidth / 51.5)),
        child: Text(
          'Re-set Default',
          style: TextStyle(
              color: AppColors.white,
              fontSize: MediaQueryUtil.screenWidth / 25.75),
        ),
      ),
    );
  }
}
