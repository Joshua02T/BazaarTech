import 'package:bazaartech/core/repositories/searchrepo.dart';
import 'package:bazaartech/model/categorymodel.dart';
import 'package:bazaartech/widget/customtoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreFilterController extends GetxController {
  int selectedStoreRating = 0;
  List<Category> selectedCategories = <Category>[];
  List<String> itemLocation = <String>[];
  final TextEditingController categoriesFieldController =
      TextEditingController();
  final TextEditingController locationsFieldController =
      TextEditingController();
  final SearchRepo _searchRepo = SearchRepo();
  List<Category> searchCategories = <Category>[];

  List<int> getSelectedCategoryIds() {
    return selectedCategories.map((c) => c.id).toList();
  }

  Future<void> fetchStoreCategories(String item, String body) async {
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

  final TextEditingController storesFieldController = TextEditingController();
  void updateSelectedStoreRating(int index) {
    selectedStoreRating = index;
    update();
  }

  void resetDefaultsStoreFilter() {
    selectedCategories.clear();
    itemLocation.clear();
    locationsFieldController.clear();
    updateSelectedStoreRating(0);
    update();
  }
}
