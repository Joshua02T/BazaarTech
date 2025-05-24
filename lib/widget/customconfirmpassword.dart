import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomConfirmPasswordField extends StatelessWidget {
  final TextEditingController textEditingController;
  final dynamic controller;
  const CustomConfirmPasswordField({
    super.key,
    required this.textEditingController,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    MediaQueryUtil.init(context);
    return Obx(() => TextFormField(
          style: TextStyle(
              color: AppColors.primaryFontColor,
              fontSize: MediaQueryUtil.screenWidth / 25.75,
              fontWeight: FontWeight.w500),
          obscureText: !controller.passwordVisible2.value,
          obscuringCharacter: '*',
          controller: textEditingController,
          keyboardType: TextInputType.visiblePassword,
          validator: (value) {
            if (controller.password != value) {
              return 'Password mismatch';
            }
            return null;
          },
          decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    controller.passwordVisible2.value =
                        !controller.passwordVisible2.value;
                  },
                  icon: controller.passwordVisible2.value
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
