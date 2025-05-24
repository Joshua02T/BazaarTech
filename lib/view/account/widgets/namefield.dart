import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/text_style.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/account/controller/accountcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NameField extends StatelessWidget {
  const NameField({super.key});

  @override
  Widget build(BuildContext context) {
    AccountController controller = Get.find<AccountController>();
    MediaQueryUtil.init(context);
    return Row(
      children: [
        Text('Name', style: FontStyles.fieldTitleStyle(context)),
        SizedBox(width: MediaQueryUtil.screenWidth / 8.4),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.name,
            controller: controller.nameController,
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
