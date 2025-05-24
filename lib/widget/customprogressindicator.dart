import 'package:bazaartech/core/const_data/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: SquareProgressIndicator(
      color: AppColors.white,
      emptyStrokeColor: AppColors.primaryOrangeColor,
    ));
  }
}
