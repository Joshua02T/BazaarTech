import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchCController extends GetxController {
  int selectedIndex = 0;
  TextEditingController? searchText;
  String categoryTitle = 'Products';
  final PageController pageController = PageController();

  @override
  void onInit() {
    searchText = TextEditingController();
    super.onInit();
  }

  void updateSelectedIndex(int index) {
    selectedIndex = index;
    update();
  }

  @override
  void onClose() {
    searchText?.dispose();
    pageController.dispose();
    super.onClose();
  }
}
