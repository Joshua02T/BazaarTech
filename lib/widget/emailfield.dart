import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:flutter/material.dart';

class CustomEmailField extends StatelessWidget {
  final TextEditingController contoller;
  const CustomEmailField({super.key, required this.contoller});

  @override
  Widget build(BuildContext context) {
    MediaQueryUtil.init(context);
    return TextFormField(
      controller: contoller,
      style: TextStyle(
          color: AppColors.primaryFontColor,
          fontSize: MediaQueryUtil.screenWidth / 25.75,
          fontWeight: FontWeight.w500),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email is required';
        }

        final RegExp gmailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');

        if (!gmailRegex.hasMatch(value)) {
          return 'Please enter a valid Gmail address';
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
