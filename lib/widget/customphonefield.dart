import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:flutter/material.dart';

class CustomPhoneField extends StatelessWidget {
  final TextEditingController controller;
  const CustomPhoneField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    MediaQueryUtil.init(context);
    return TextFormField(
      maxLength: 10,
      controller: controller,
      keyboardType: TextInputType.phone,
      style: TextStyle(
          color: AppColors.primaryFontColor,
          fontSize: MediaQueryUtil.screenWidth / 25.75,
          fontWeight: FontWeight.w500),
      validator: (phoneNumber) {
        if (phoneNumber!.isEmpty) {
          return 'Phone number cannot be empty';
        }
        if (!RegExp(r'^09\d{8}$').hasMatch(phoneNumber)) {
          return 'Phone number must start with 09 and be exactly 10 digits';
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: '09**',
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
