import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomPasswordField extends StatelessWidget {
  final TextEditingController textEditingController;
  final dynamic controller;
  const CustomPasswordField(
      {super.key,
      required this.textEditingController,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    MediaQueryUtil.init(context);
    return Obx(() => TextFormField(
          obscureText: !controller.passwordVisible.value,
          obscuringCharacter: '*',
          controller: textEditingController,
          style: TextStyle(
              color: AppColors.primaryFontColor,
              fontSize: MediaQueryUtil.screenWidth / 25.75,
              fontWeight: FontWeight.w500),
          keyboardType: TextInputType.visiblePassword,
          onSaved: (newValue) {
            controller.password = newValue;
          },
          validator: (password) {
            if (password!.isEmpty) {
              return 'Password cannot be empty';
            }
            if (password.length < 8) {
              return 'Password must be at least 8 characters long';
            }
            if (!RegExp(r'[A-Z]').hasMatch(password)) {
              return 'Password must contain at least one uppercase letter';
            }
            if (!RegExp(r'[a-z]').hasMatch(password)) {
              return 'Password must contain at least one lowercase letter';
            }
            if (!RegExp(r'[0-9]').hasMatch(password)) {
              return 'Password must contain at least one digit';
            }
            if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) {
              return 'Password must contain at least one special character';
            }
            return null;
          },
          decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    controller.passwordVisible.value =
                        !controller.passwordVisible.value;
                  },
                  icon: controller.passwordVisible.value
                      ? const Icon(Icons.visibility,
                          color: AppColors.primaryOrangeColor)
                      : const Icon(Icons.visibility_off)),
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
        ));
  }
}
