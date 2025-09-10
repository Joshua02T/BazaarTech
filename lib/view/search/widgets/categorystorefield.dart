import 'package:bazaartech/view/search/controller/storefiltercontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/service/media_query.dart';

class CategoryStoreField extends StatelessWidget {
  const CategoryStoreField({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreFilterController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (controller.selectedCategories.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQueryUtil.screenHeight / 105.5,
                ),
                child: Wrap(
                  spacing: MediaQueryUtil.screenWidth / 68.6,
                  children: controller.selectedCategories.map((category) {
                    return Chip(
                      side: BorderSide.none,
                      color: const WidgetStatePropertyAll(
                        AppColors.secondaryOrangeColor,
                      ),
                      label: Text(
                        category,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: AppColors.black),
                      ),
                      deleteIcon: Icon(
                        Icons.close,
                        size: MediaQueryUtil.screenWidth / 22.88,
                      ),
                      onDeleted: () {
                        controller.selectedCategories.remove(category);
                        controller.update();
                      },
                    );
                  }).toList(),
                ),
              ),
            TextFormField(
              style: const TextStyle(color: AppColors.black),
              validator: (value) {
                return controller.selectedCategories.isEmpty
                    ? 'Select one category at least!'
                    : null;
              },
              controller: controller.categoriesFieldController,
              keyboardType: TextInputType.text,
              onChanged: (value) =>
                  controller.fetchStoreCategories('store', value.trim()),
              onFieldSubmitted: (value) {
                if (value.trim().isNotEmpty) {
                  controller.selectedCategories.add(value.trim());
                  controller.categoriesFieldController.clear();
                  controller.update();
                }
              },
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.all(MediaQueryUtil.screenWidth / 34.33),
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
            if (controller.searchCategories.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.searchCategories.length,
                  itemBuilder: (context, index) {
                    final category = controller.searchCategories[index];
                    return ListTile(
                      title: Text(category.name),
                      onTap: () {
                        controller.selectedCategories.add(category.name);
                        controller.categoriesFieldController.clear();
                        controller.searchCategories.clear();
                        controller.update();
                      },
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
