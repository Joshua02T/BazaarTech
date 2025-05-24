import 'package:bazaartech/core/const_data/font_family.dart';
import 'package:flutter/material.dart';

class Themes {
  static ThemeData appTheme() {
    return ThemeData(useMaterial3: true, fontFamily: FontFamily.montserrat);
  }

  static ThemeData darkTheme = ThemeData.dark().copyWith(
      textTheme:
          ThemeData.dark().textTheme.apply(fontFamily: FontFamily.montserrat));
  static ThemeData lightTheme = ThemeData.light().copyWith(
      textTheme:
          ThemeData.dark().textTheme.apply(fontFamily: FontFamily.montserrat));
}
// import 'package:bazaartech/core/const_data/app_colors.dart';
// import 'package:bazaartech/core/const_data/font_family.dart';
// import 'package:flutter/material.dart';

// class Themes {
//   static ThemeData lightTheme = ThemeData(
//     useMaterial3: true,
//     fontFamily: FontFamily.montserrat,
//     scaffoldBackgroundColor: AppColors.backgroundColor,
//     primaryColor: AppColors.primaryOrangeColor,
//     textTheme: ThemeData.light().textTheme.apply(
//           fontFamily: FontFamily.montserrat,
//         ),
//     colorScheme: ColorScheme.light(
//       primary: AppColors.primaryOrangeColor,
//       secondary: AppColors.secondaryOrangeColor,
//       background: AppColors.backgroundColor,
//       onPrimary: AppColors.white,
//       onSecondary: AppColors.primaryFontColor,
//       surface: AppColors.lightGrey,
//       onSurface: AppColors.primaryFontColor,
//     ),
//   );

//   static ThemeData darkTheme = ThemeData(
//     useMaterial3: true,
//     fontFamily: FontFamily.montserrat,
//     scaffoldBackgroundColor: DarkAppColors.backgroundColor,
//     primaryColor: DarkAppColors.primaryOrangeColor,
//     textTheme: ThemeData.dark().textTheme.apply(
//           fontFamily: FontFamily.montserrat,
//         ),
//     colorScheme: ColorScheme.dark(
//       primary: DarkAppColors.primaryOrangeColor,
//       secondary: DarkAppColors.secondaryOrangeColor,
//       background: Color.fromARGB(255, 255, 0, 0),
//       onPrimary: Color.fromARGB(255, 255, 0, 0),
//       onSecondary: DarkAppColors.primaryFontColor,
//       surface: DarkAppColors.lightGrey,
//       onSurface: DarkAppColors.primaryFontColor,
//     ),
//   );
// }
