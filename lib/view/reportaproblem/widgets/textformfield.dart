import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:bazaartech/core/service/media_query.dart';
import 'package:bazaartech/view/reportaproblem/controller/reportcontroller.dart';
import 'package:flutter/material.dart';

class IssueTextField extends StatelessWidget {
  final ReportaProblemController controller;
  const IssueTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    MediaQueryUtil.init(context);
    return TextFormField(
      cursorErrorColor: AppColors.red,
      controller: controller.textEditingController,
      style: const TextStyle(color: AppColors.primaryFontColor),
      keyboardType: TextInputType.text,
      minLines: 4,
      maxLines: 4,
      validator: (input) {
        if (input == null || input.trim().isEmpty) {
          return 'Please describe the problem';
        }
        if (input.trim().length < 10) {
          return 'The description must be at least 10 characters long';
        }
        if (input.startsWith(' ')) {
          return 'The description should not start with a space';
        }
        return null;
      },
      decoration: InputDecoration(
        errorStyle:
            const TextStyle(color: AppColors.red, fontWeight: FontWeight.w500),
        hintText: 'Describe the issue...',
        hintStyle: TextStyle(
            fontSize: MediaQueryUtil.screenWidth / 25.75,
            color: AppColors.darkGrey),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: AppColors.borderLightGrey,
              width: MediaQueryUtil.screenWidth / 206),
          borderRadius: BorderRadius.all(
            Radius.circular(MediaQueryUtil.screenWidth / 34.33),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: AppColors.borderLightGrey,
              width: MediaQueryUtil.screenWidth / 412),
          borderRadius: BorderRadius.all(
            Radius.circular(MediaQueryUtil.screenWidth / 34.33),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: AppColors.red, width: MediaQueryUtil.screenWidth / 412),
          borderRadius: BorderRadius.all(
            Radius.circular(MediaQueryUtil.screenWidth / 34.33),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: AppColors.red, width: MediaQueryUtil.screenWidth / 412),
          borderRadius: BorderRadius.all(
            Radius.circular(MediaQueryUtil.screenWidth / 34.33),
          ),
        ),
      ),
    );
  }
}
