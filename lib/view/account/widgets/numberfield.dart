import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/const_data/text_style.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/account/controller/accountcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NumberField extends StatelessWidget {
  const NumberField({super.key});

  @override
  Widget build(BuildContext context) {
    AccountController controller = Get.find<AccountController>();
    return Row(
      children: [
        Text('Number', style: FontStyles.fieldTitleStyle(context)),
        SizedBox(width: MediaQueryUtil.screenWidth / 8.4),
        Expanded(
          child: TextFormField(
            maxLength: 10,
            keyboardType: TextInputType.phone,
            controller: controller.phoneController,
            validator: (phoneNumber) {
              if (phoneNumber!.isEmpty) {
                return 'Phone number cannot be empty';
              }
              if (!RegExp(r'^09\d{8}$').hasMatch(phoneNumber)) {
                return 'Phone number must start with 09 and be exactly 10 digits';
              }
              return null;
            },
            style: TextStyle(
                color: AppColors.primaryFontColor,
                fontSize: MediaQueryUtil.screenWidth / 20.6,
                fontWeight: FontWeight.w500),
            decoration: const InputDecoration(
              hintText: '09**',
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
