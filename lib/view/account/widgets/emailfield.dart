import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/text_style.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/account/controller/accountcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailField extends StatelessWidget {
  const EmailField({super.key});

  @override
  Widget build(BuildContext context) {
    AccountController controller = Get.find<AccountController>();
    return Row(
      children: [
        Text('Email', style: FontStyles.fieldTitleStyle(context)),
        SizedBox(width: MediaQueryUtil.screenWidth / 8.4),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: controller.emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email is required';
              }

              final RegExp gmailRegex =
                  RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');

              if (!gmailRegex.hasMatch(value)) {
                return 'Please enter a valid Gmail address';
              }

              return null;
            },
            style: TextStyle(
                color: AppColors.primaryFontColor,
                fontSize: MediaQueryUtil.screenWidth / 20.6,
                fontWeight: FontWeight.w500),
            decoration: const InputDecoration(
              isDense: true,
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.darkGrey)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.darkGrey)),
              errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.darkGrey)),
              focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.darkGrey)),
            ),
          ),
        ),
      ],
    );
  }
}
