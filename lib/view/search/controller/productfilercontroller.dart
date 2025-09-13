import 'package:bazaartech/core/repositories/searchrepo.dart';
import 'package:bazaartech/model/categorymodel.dart';
import 'package:bazaartech/widget/customtoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductFilterController extends GetxController {
  int selectedProductRating = 0;
  List<String> itemLocation = <String>[];
  List<Category> selectedCategories = <Category>[];
  final TextEditingController minPrice = TextEditingController();
  final TextEditingController maxPrice = TextEditingController();
  final TextEditingController locationsFieldController =
      TextEditingController();
  final TextEditingController categoriesFieldController =
      TextEditingController();
  final SearchRepo _searchRepo = SearchRepo();
  List<Category> searchCategories = <Category>[];
  void updateSelectedProductRating(int index) {
    selectedProductRating = index;
    update();
  }

  List<int> getSelectedCategoryIds() {
    return selectedCategories.map((c) => c.id).toList();
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
    itemLocation.clear();
    updateSelectedProductRating(0);
    update();
  }
}
