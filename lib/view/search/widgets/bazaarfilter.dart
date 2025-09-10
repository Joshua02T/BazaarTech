import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/const_data/lists.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/search/controller/filtersearchcontroller.dart';
import 'package:bazaartech/view/search/widgets/buttons.dart';
import 'package:bazaartech/view/search/widgets/categoryfield.dart';
import 'package:bazaartech/view/search/widgets/custombazaarstatus.dart';
import 'package:bazaartech/view/search/widgets/locationfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BazaarSearchFilter extends StatelessWidget {
  const BazaarSearchFilter({super.key});

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
                      'Status',
                      style: TextStyle(
                        fontSize: MediaQueryUtil.screenWidth / 25.75,
                        color: AppColors.primaryFontColor,
                      ),
                    ),
                    SizedBox(height: MediaQueryUtil.screenHeight / 52.75),
                    SizedBox(
                      height: MediaQueryUtil.screenHeight / 19.18,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(bazaarStatus.length, (index) {
                          return GestureDetector(
                              onTap: () => controller
                                  .updateSelectedIndexBazaarStatus(index),
                              child: GetBuilder<FilterSearchController>(
                                builder: (controller) {
                                  final isSelected =
                                      controller.selectedIndexBazaarStatus ==
                                          index;
                                  return CustomBazaarStatusContainer(
                                      bazaarStatus: bazaarStatus[index],
                                      isSelected: isSelected);
                                },
                              ));
                        }),
                      ),
                    ),
                    GetBuilder<FilterSearchController>(
                      builder: (controller) {
                        final selectedIndex =
                            controller.selectedIndexBazaarStatus;
                        if (selectedIndex != 1) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height: MediaQueryUtil.screenHeight / 26.375),
                              Text(
                                'Time',
                                style: TextStyle(
                                  fontSize: MediaQueryUtil.screenWidth / 25.75,
                                  color: AppColors.primaryFontColor,
                                ),
                              ),
                              SizedBox(
                                  height: MediaQueryUtil.screenHeight / 52.75),
                              TextFormField(
                                style: const TextStyle(color: AppColors.black),
                                controller: selectedIndex == 0
                                    ? controller.bazaarPastDate
                                    : controller.bazaarUpComingDate,
                                keyboardType: TextInputType.datetime,
                                validator: (value) =>
                                    controller.validateDate(value),
                                readOnly: true,
                                decoration: InputDecoration(
                                  suffixIcon: Image.asset(
                                      AppImages.calendarIcon,
                                      scale:
                                          MediaQueryUtil.screenWidth / 228.9),
                                  contentPadding: EdgeInsets.all(
                                      MediaQueryUtil.screenWidth / 34.33),
                                  fillColor: AppColors.white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(
                                        MediaQueryUtil.screenWidth / 51.5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(
                                        MediaQueryUtil.screenWidth / 51.5),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        MediaQueryUtil.screenWidth / 51.5),
                                  ),
                                ),
                                onTap: () => selectedIndex == 0
                                    ? controller.pickPastDate(context)
                                    : controller.pickUpComingDate(context),
                              ),
                            ],
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
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
                      categories: controller.selectedBazaarCategories,
                      categoryController: controller.categoriesFieldController,
                      onFieldSubmitted: (value) {},
                      onDeleted: (value) {},
                      onFieldChanged: (value) {},
                    ),
                    SizedBox(height: MediaQueryUtil.screenHeight / 26.375),
                    Text(
                      'Location',
                      style: TextStyle(
                        fontSize: MediaQueryUtil.screenWidth / 25.75,
                        color: AppColors.black,
                      ),
                    ),
                    SizedBox(height: MediaQueryUtil.screenHeight / 52.75),
                    CustomLocationField(
                        stores: controller.bazaarStoreLocation,
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
              onPressed: () => controller.resetDefaultsBazaarFilter())
        ],
      ),
    );
  }
}
