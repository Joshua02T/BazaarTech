import 'package:bazaartech/core/repositories/searchrepo.dart';
import 'package:bazaartech/model/categorymodel.dart';
import 'package:bazaartech/widget/customtoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductFilterController extends GetxController {
  int selectedProductRating = 0;
  List<String> productStoreLocation = <String>[];
  List<String> selectedCategories = <String>[];
  final TextEditingController minPrice = TextEditingController();
  final TextEditingController maxPrice = TextEditingController();
  final TextEditingController storesFieldController = TextEditingController();
  final TextEditingController categoriesFieldController =
      TextEditingController();
  GlobalKey<FormState> filterProductKey = GlobalKey<FormState>();
  final SearchRepo _searchRepo = SearchRepo();
  List<Category> searchCategories = <Category>[];
  void updateSelectedProductRating(int index) {
    selectedProductRating = index;
    update();
  }

  Future<void> fetchProductCategories(String item, String body) async {
    try {
      final fetchedCategories =
          await _searchRepo.fetchSearchCategories(item, body);
      searchCategories.clear();
      searchCategories.assignAll(fetchedCategories);
    } catch (e) {
      ToastUtil.showToast('Failed to load categories, ${e.toString()}');
    } finally {
      update();
    }
  }

  void resetDefaultsProductFilter() {
    minPrice.clear();
    maxPrice.clear();
    selectedCategories.clear();
    productStoreLocation.clear();
    updateSelectedProductRating(0);
    update();
  }

  String? validateMinPrice(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a price';
    }

    if (value.trim().startsWith('.') || value.trim().endsWith('.')) {
      return 'Invalid price format';
    }

    if (value.trim().startsWith('0') && value.trim().length > 1) {
      return 'Price cannot start with zero';
    }

    try {
      double price = double.parse(value.trim());

      if (price < 0) {
        return 'Price cannot be negative';
      }

      if (price == 0) {
        return 'Price cannot be zero';
      }

      return null;
    } catch (e) {
      return 'Invalid price format';
    }
  }

  String? validateMaxPrice(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a price';
    }

    if (value.trim().startsWith('.') || value.trim().endsWith('.')) {
      return 'Invalid price format';
    }

    if (value.trim().startsWith('0') && value.trim().length > 1) {
      return 'Price cannot start with zero';
    }

    try {
      double price = double.parse(value.trim());

      if (price < 0) {
        return 'Price cannot be negative';
      }

      if (price == 0) {
        return 'Price cannot be zero';
      }

      return null;
    } catch (e) {
      return 'Invalid price format';
    }
  }
}
