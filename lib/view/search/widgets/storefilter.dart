import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/lists.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/search/controller/filtersearchcontroller.dart';
import 'package:bazaartech/view/search/widgets/buttons.dart';
import 'package:bazaartech/view/search/widgets/categoryfield.dart';
import 'package:bazaartech/view/search/widgets/customratingcontainer.dart';
import 'package:bazaartech/view/search/widgets/locationfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreSearchFilter extends StatelessWidget {
  const StoreSearchFilter({super.key});

  @override
  Widget build(BuildContext context) {
    FilterSearchController controller = Get.find<FilterSearchController>();
    return Form(
      key: controller.filterKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQueryUtil.screenWidth / 20.6,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rating',
                      style: TextStyle(
                        fontSize: MediaQueryUtil.screenWidth / 25.75,
                        color: AppColors.primaryFontColor,
                      ),
                    ),
                    SizedBox(height: MediaQueryUtil.screenHeight / 52.75),
                    SizedBox(
                      height: MediaQueryUtil.screenHeight / 19.18,
                      child: ListView.builder(
                        clipBehavior: Clip.none,
                        scrollDirection: Axis.horizontal,
                        itemCount: ratingNumbers.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () =>
                                  controller.updateSelectedStoreRating(index),
                              child: GetBuilder<FilterSearchController>(
                                builder: (controller) {
                                  final isSelected =
                                      controller.selectedStoreRating == index;
                                  return CustomRatingContainer(
                                    ratingNumber: ratingNumbers[index],
                                    isSelected: isSelected,
                                  );
                                },
                              ));
                        },
                      ),
                    ),
                    SizedBox(height: MediaQueryUtil.screenHeight / 26.375),
                    Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: MediaQueryUtil.screenWidth / 25.75,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: MediaQueryUtil.screenHeight / 52.75),
                    CustomCategoryField(
                        onFieldChanged: (value) =>
                            controller.fetchCategories('store', 'value'),
                        categories: controller.selectedStoreCategories,
                        categoryController:
                            controller.categoriesFieldController,
                        onFieldSubmitted: (value) {},
                        onDeleted: (value) {}),
                    SizedBox(height: MediaQueryUtil.screenHeight / 26.875),
                    Text(
                      'Location',
                      style: TextStyle(
                        fontSize: MediaQueryUtil.screenWidth / 25.75,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: MediaQueryUtil.screenHeight / 52.75),
                    CustomLocationField(
                        stores: controller.storeStoreLocation,
                        locationController: controller.storesFieldController,
                        onFieldSubmitted: (value) {},
                        onDeleted: (value) {})
                  ],
                ),
              ),
            ),
          ),
          DefaultAndSave(
              controller: controller,
              onPressed: () => controller.resetDefaultsStoreFilter())
        ],
      ),
    );
  }
}
