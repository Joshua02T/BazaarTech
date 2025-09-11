import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/lists.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/search/controller/productfilercontroller.dart';
import 'package:bazaartech/view/search/widgets/resetbutton.dart';
import 'package:bazaartech/view/search/widgets/categoryproductfield.dart';
import 'package:bazaartech/view/search/widgets/customratingcontainer.dart';
import 'package:bazaartech/view/search/widgets/locationfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductSearchFilter extends StatelessWidget {
  const ProductSearchFilter({super.key});

  @override
  Widget build(BuildContext context) {
    ProductFilterController controller = Get.find<ProductFilterController>();
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                right: MediaQueryUtil.screenWidth / 20.6,
                left: MediaQueryUtil.screenWidth / 20.6,
                bottom: 200,
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
                                controller.updateSelectedProductRating(index),
                            child: GetBuilder<ProductFilterController>(
                              builder: (controller) {
                                final isSelected =
                                    controller.selectedProductRating == index;
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
                    'Price',
                    style: TextStyle(
                      fontSize: MediaQueryUtil.screenWidth / 25.75,
                      color: AppColors.primaryFontColor,
                    ),
                  ),
                  SizedBox(height: MediaQueryUtil.screenHeight / 52.75),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          style: const TextStyle(color: AppColors.black),
                          validator: (value) =>
                              controller.validateMinPrice(value),
                          controller: controller.minPrice,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'min',
                            contentPadding: EdgeInsets.all(
                                MediaQueryUtil.screenWidth / 34.33),
                            fillColor: AppColors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(
                                MediaQueryUtil.screenWidth / 51.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(
                                MediaQueryUtil.screenWidth / 51.5,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                MediaQueryUtil.screenWidth / 51.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: MediaQueryUtil.screenWidth / 20.6),
                      Expanded(
                        child: TextFormField(
                          style: const TextStyle(color: AppColors.black),
                          validator: (value) =>
                              controller.validateMaxPrice(value),
                          controller: controller.maxPrice,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'max',
                            contentPadding: EdgeInsets.all(
                                MediaQueryUtil.screenWidth / 34.33),
                            fillColor: AppColors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(
                                MediaQueryUtil.screenWidth / 51.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(
                                MediaQueryUtil.screenWidth / 51.5,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                MediaQueryUtil.screenWidth / 51.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
                  const CategoryProductField(),
                  SizedBox(height: MediaQueryUtil.screenHeight / 26.875),
                  Text(
                    'Store Location',
                    style: TextStyle(
                      fontSize: MediaQueryUtil.screenWidth / 25.75,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: MediaQueryUtil.screenHeight / 52.75),
                  CustomLocationField(
                      stores: controller.productStoreLocation,
                      locationController: controller.storesFieldController,
                      onDeleted: (value) {},
                      onFieldSubmitted: (value) {})
                ],
              ),
            ),
          ),
        ),
        const ResetDefaultButton(controllerKind: 'product')
      ],
    );
  }
}
