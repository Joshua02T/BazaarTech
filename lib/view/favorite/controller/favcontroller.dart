import 'package:bazaartech/core/repositories/favoriterepo.dart';
import 'package:bazaartech/view/home/model/bazaarmodel.dart';
import 'package:bazaartech/view/home/model/productmodel.dart';
import 'package:bazaartech/view/home/model/storemodel.dart';
import 'package:bazaartech/widget/customtoast.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  final FavoriteRepository favoriteRepo = FavoriteRepository();
  int selectedIndex = 0;
  final PageController pageController = PageController();
  bool isLoading = false;
  List<Product> productsInFav = <Product>[];
  List<Store> storseInFav = <Store>[];
  List<Bazaar> bazaarsInFav = <Bazaar>[];

  Future<void> loadFavorites() async {
    try {
      isLoading = true;
      update();

      final products = await favoriteRepo.fetchProductFav();
      productsInFav.assignAll(products);

      final stores = await favoriteRepo.fetchStoreFav();
      storseInFav.assignAll(stores);

      final bazaars = await favoriteRepo.fetchBazaarFav();
      bazaarsInFav.assignAll(bazaars);
    } catch (e) {
      ToastUtil.showToast('Failed to load items, ${e.toString()}');
    } finally {
      isLoading = false;
      update();
    }
  }

  void updateSelectedIndex(int index) {
    selectedIndex = index;
    update();
  }

  Future<void> refreshData() async {
    try {
      await loadFavorites();
      updateSelectedIndex(0);
    } catch (e) {
      ToastUtil.showToast("Couldn't refresh data");
    }
  }

  @override
  void onInit() {
    loadFavorites();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
