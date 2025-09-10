import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCategoryField extends StatelessWidget {
  final List<String> categories;
  final void Function(String) onDeleted;
  final TextEditingController categoryController;
  final void Function(String) onFieldSubmitted;
  final void Function(String) onFieldChanged;
  const CustomCategoryField(
      {super.key,
      required this.categories,
      required this.categoryController,
      required this.onFieldSubmitted,
      required this.onDeleted,
      required this.onFieldChanged});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (categories.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQueryUtil.screenHeight / 105.5),
                child: Wrap(
                  spacing: MediaQueryUtil.screenWidth / 68.6,
                  children: categories.map((category) {
                    return Chip(
                      side: BorderSide.none,
                      color: const WidgetStatePropertyAll(
                          AppColors.secondaryOrangeColor),
                      label: Text(
                        category,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: AppColors.black),
                      ),
                      deleteIcon: Icon(Icons.close,
                          size: MediaQueryUtil.screenWidth / 22.88),
                      onDeleted: () {
                        onDeleted(category);
                      },
                    );
                  }).toList(),
                ),
              ),
            TextFormField(
              style: const TextStyle(color: AppColors.black),
              validator: (value) {
                return categories.isEmpty
                    ? 'Select one category at least!'
                    : null;
              },
              controller: categoryController,
              keyboardType: TextInputType.text,
              onChanged: (value) => onFieldChanged(value.trim()),
              onFieldSubmitted: (value) {
                onFieldSubmitted(value.trim());
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
          ],
        ));
  }
}
