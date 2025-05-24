import 'package:flutter/material.dart';

class MediaQueryUtil {
  //412 Width
  //844 Height
  static late double screenWidth;
  static late double screenHeight;

  static void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }
}
