import 'package:bazaartech/core/repositories/bazaarrepo.dart';
import 'package:bazaartech/core/repositories/favoriterepo.dart';
import 'package:bazaartech/core/repositories/productrepo.dart';
import 'package:bazaartech/core/repositories/storerepo.dart';
import 'package:bazaartech/view/home/model/bazaarmodel.dart';
import 'package:bazaartech/view/home/model/productmodel.dart';
import 'package:bazaartech/view/home/model/storemodel.dart';
import 'package:bazaartech/widget/customtoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  final ProductRepository productRepo = ProductRepository();
  final StoreRepository storeRepo = StoreRepository();

  final List<Product> productCardItem = <Product>[];
  final List<Store> storeCardItem = <Store>[];

  bool isLoading = false;

  int selectedIndex = 0;
  final PageController pageController = PageController();

  final List<dynamic> allItems = <dynamic>[];

  Future<void> loadInitialData() async {
    try {
      isLoading = true;
      update();

      final products = await productRepo.fetchProducts();
      productCardItem.assignAll(products);

      final stores = await storeRepo.fetchStores();
      storeCardItem.assignAll(stores);

      final tempItems = [
        ...productCardItem
            .map((product) => {'type': 'product', 'data': product}),
        ...storeCardItem.map((store) => {'type': 'store', 'data': store}),
      ];
      allItems.assignAll(tempItems);
      allItems.shuffle();
    } catch (e) {
      print(e.toString());
      ToastUtil.showToast('Failed to load data, ${e.toString()}');
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> refreshData() async {
    try {
      await loadInitialData();
      updateSelectedIndex(0);
    } catch (e) {
      ToastUtil.showToast("Couldn't refresh products");
    }
  }

  void updateSelectedIndex(int index) {
    selectedIndex = index;
    update();
  }

  @override
  void onInit() {
    loadInitialData();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
