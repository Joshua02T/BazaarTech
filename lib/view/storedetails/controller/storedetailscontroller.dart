import 'package:bazaartech/core/repositories/storerepo.dart';
import 'package:bazaartech/model/commentmodel.dart';
import 'package:bazaartech/view/home/model/categorymodel.dart';
import 'package:bazaartech/view/home/model/productmodel.dart';
import 'package:bazaartech/view/home/model/storemodel.dart';
import 'package:bazaartech/widget/customtoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:url_launcher/url_launcher.dart';

class StoreDetailsController extends GetxController {
  final String id;
  StoreDetailsController(this.id);
  final StoreRepository _storeRepository = StoreRepository();
  Store? store;
  bool isLoadingFetching = false;
  final List<String> productCategories = <String>[];
  int selectedProductCategoryIndex = 0;
  PageController pageController = PageController();
  final List<Comment> comments = <Comment>[];

  int rating = 0;
  void setRating(int value) {
    rating = value;
    update();
  }

  void updateSelectedProductCategoryIndex(int index) {
    selectedProductCategoryIndex = index;
    update();
  }

  Future<void> fetchStore(String id) async {
    try {
      isLoadingFetching = true;
      update();
      final fetchedStore = await _storeRepository.fetchStoreById(id);
      store = fetchedStore;
      comments.assignAll(fetchedStore!.comments);
      fetchProductCategories();
    } catch (e) {
      ToastUtil.showToast('Failed to load store, ${e.toString()}');
      print(e.toString());
    } finally {
      isLoadingFetching = false;
      update();
    }
  }

  void fetchProductCategories() {
    if (store != null) {
      productCategories.clear();

      for (Category c in store!.categories) {
        productCategories.add(c.name);
      }

      selectedProductCategoryIndex = 0;
      update();
    }
  }

  List<Product> get filteredProductsForCurrentCategory {
    if (store == null) return [];

    final selectedCategory = productCategories[selectedProductCategoryIndex];

    return store!.products
        .where((p) => p.category == selectedCategory)
        .toList();
  }

  Future<void> callStore() async {
    String phoneNumber = store!.storeNumber.toString();
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (!await launchUrl(phoneUri, mode: LaunchMode.externalApplication)) {
      ToastUtil.showToast('Could not launch $phoneUri');
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    fetchStore(id);
    super.onInit();
  }
}
