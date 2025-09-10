import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:flutter/material.dart';

class CustomLocationField extends StatelessWidget {
  final List<String> stores;
  final void Function(String) onDeleted;
  final TextEditingController locationController;
  final void Function(String) onFieldSubmitted;
  const CustomLocationField(
      {super.key,
      required this.stores,
      required this.locationController,
      required this.onFieldSubmitted,
      required this.onDeleted});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (stores.isNotEmpty)
          Padding(
            padding:
                EdgeInsets.only(bottom: MediaQueryUtil.screenHeight / 105.5),
            child: Wrap(
              spacing: MediaQueryUtil.screenWidth / 68.6,
              children: stores.map((store) {
                return Chip(
                  side: BorderSide.none,
                  color: const WidgetStatePropertyAll(
                      AppColors.secondaryOrangeColor),
                  label: Text(
                    store,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: AppColors.black),
                  ),
                  deleteIcon: Icon(Icons.close,
                      size: MediaQueryUtil.screenWidth / 22.88),
                  onDeleted: () {
                    onDeleted(store);
                  },
                );
              }).toList(),
            ),
          ),
        TextFormField(
          style: const TextStyle(color: AppColors.black),
          validator: (value) {
            return stores.isEmpty ? 'Select one store at least!' : null;
          },
          controller: locationController,
          keyboardType: TextInputType.text,
          onFieldSubmitted: (value) {
            onFieldSubmitted(value.trim());
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(MediaQueryUtil.screenWidth / 34.33),
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
    );
  }
}
