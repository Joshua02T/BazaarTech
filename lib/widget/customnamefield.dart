import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:flutter/material.dart';

class CustomNameField extends StatelessWidget {
  final TextEditingController contoller;
  const CustomNameField({super.key, required this.contoller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: contoller,
      keyboardType: TextInputType.name,
      style: TextStyle(
          color: AppColors.primaryFontColor,
          fontSize: MediaQueryUtil.screenWidth / 25.75,
          fontWeight: FontWeight.w500),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Name is required';
        }

        final RegExp nameRegex = RegExp(r"^[a-zA-Z\s]+$");

        if (!nameRegex.hasMatch(value)) {
          return 'Name must contain only letters and spaces';
        }

        if (value.trim().length < 2) {
          return 'Name must be at least 2 characters long';
        }

        return null;
      },
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(MediaQueryUtil.screenWidth / 34.3),
              borderSide: const BorderSide(color: Colors.orange)),
          focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(MediaQueryUtil.screenWidth / 34.3),
              borderSide: const BorderSide(color: Colors.orange)),
          errorBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(MediaQueryUtil.screenWidth / 34.3),
              borderSide: const BorderSide(color: Colors.orange)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(MediaQueryUtil.screenWidth / 34.3),
              borderSide: const BorderSide(color: Colors.orange))),
    );
  }
}
