import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/text_style.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/account/controller/accountcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AgeField extends StatelessWidget {
  const AgeField({super.key});

  @override
  Widget build(BuildContext context) {
    AccountController controller = Get.find<AccountController>();
    return Row(
      children: [
        Text('Age', style: FontStyles.fieldTitleStyle(context)),
        SizedBox(width: MediaQueryUtil.screenWidth / 8.4),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.number,
            controller: controller.ageController,
            validator: (input) {
              if (input == null || input.trim().isEmpty) {
                return 'Age cannot be empty';
              }
              final age = int.tryParse(input);
              if (age == null) {
                return 'Age must be a valid number';
              }
              if (age < 12) {
                return 'Age must be at least 12';
              }
              if (age > 120) {
                return 'Age must not exceed 120';
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
