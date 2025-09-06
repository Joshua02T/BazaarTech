import 'package:bazaartech/core/repositories/favoriterepo.dart';
import 'package:bazaartech/view/home/controller/home_controller.dart';
import 'package:bazaartech/widget/customtoast.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  final HomeController homeController = Get.find<HomeController>();
  final FavoriteRepository favoriteRepo = FavoriteRepository();
  int selectedIndex = 0;
  final PageController pageController = PageController();
  bool isLoading = false;

  Future<void> loadFavorites() async {
    // try {
    //   isLoading = true;
    //   update();
    //   final favorites =
    //       await favoriteRepo.fetchFavorites(homeController.favoriteItems);
    //   homeController.favoriteItems.assignAll(favorites);
    // } catch (e) {
    //   ToastUtil.showToast('Failed to load favorites');
    // } finally {
    //   isLoading = false;
    //   update();
    // }
  }

  void updateSelectedIndex(int index) {
    selectedIndex = index;
    update();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
