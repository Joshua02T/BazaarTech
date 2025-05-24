import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchCController extends GetxController {
  RxInt selectedIndex = 0.obs;
  TextEditingController? searchText;
  RxString categoryTitle = 'Products'.obs;
  final PageController pageController = PageController();

  @override
  void onInit() {
    searchText = TextEditingController();
    super.onInit();
  }

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  @override
  void onClose() {
    searchText?.dispose();
    pageController.dispose();
    super.onClose();
  }
}
