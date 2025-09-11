import 'package:bazaartech/core/repositories/bazaarrepo.dart';
import 'package:bazaartech/core/repositories/productrepo.dart';
import 'package:bazaartech/core/repositories/searchrepo.dart';
import 'package:bazaartech/core/repositories/storerepo.dart';
import 'package:bazaartech/view/home/model/bazaarmodel.dart';
import 'package:bazaartech/view/home/model/productmodel.dart';
import 'package:bazaartech/view/home/model/storemodel.dart';
import 'package:bazaartech/view/search/controller/productfilercontroller.dart';
import 'package:bazaartech/widget/customtoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchCController extends GetxController {
  int selectedIndex = 0;
  final ProductFilterController productFilterController =
      Get.find<ProductFilterController>();
  TextEditingController? searchText;
  String categoryTitle = 'Products';
  final PageController pageController = PageController();
  List<Product> resultSearchProducts = <Product>[];
  List<Store> resultSearchStores = <Store>[];
  List<Bazaar> resultSearchBazaars = <Bazaar>[];
  final ProductRepository _productRepo = ProductRepository();
  final StoreRepository _storeRepo = StoreRepository();
  final BazaarRepository _bazaarRepo = BazaarRepository();
  bool isLoading = false;

  Future<void> searchForProducts(String name, String minRating, String minPrice,
      String maxPrice, List<int> categoryIds) async {
    try {
      isLoading = true;
      update();
      final products = await _productRepo.fetchProducts(
          name, minRating, minPrice, maxPrice, categoryIds);
      resultSearchProducts.assignAll(products);
    } catch (e) {
      ToastUtil.showToast('Failed to load products, ${e.toString()}');
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> searchForStores(String name) async {
    try {
      isLoading = true;
      update();
      final stores = await _storeRepo.fetchStores(name);
      resultSearchStores.assignAll(stores);
    } catch (e) {
      ToastUtil.showToast('Failed to load stores, ${e.toString()}');
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> searchForBazaars(String name) async {
    try {
      isLoading = true;
      update();
      final bazaars = await _bazaarRepo.fetchBazaars(name);
      resultSearchBazaars.assignAll(bazaars);
    } catch (e) {
      ToastUtil.showToast('Failed to load bazaars, ${e.toString()}');
    } finally {
      isLoading = false;
      update();
    }
  }

  void onSearchChanged(String value) {
    if (selectedIndex == 0) {
      if (value.isEmpty) {
        resultSearchProducts.clear();
        update();
      } else {
        searchForProducts(
          value,
          (productFilterController.selectedProductRating + 1).toString(),
          productFilterController.minPrice.text,
          productFilterController.maxPrice.text,
          productFilterController.getSelectedCategoryIds(),
        );
      }
    } else if (selectedIndex == 1) {
      if (value.isEmpty) {
        resultSearchStores.clear();
        update();
      } else {
        searchForStores(value);
      }
    } else {
      if (value.isEmpty) {
        resultSearchBazaars.clear();
        update();
      } else {
        searchForBazaars(value);
      }
    }
  }

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
