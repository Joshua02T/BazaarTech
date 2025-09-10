import 'package:bazaartech/core/repositories/searchrepo.dart';
import 'package:bazaartech/model/categorymodel.dart';
import 'package:bazaartech/widget/customtoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreFilterController extends GetxController {
  int selectedStoreRating = 0;
  List<String> selectedCategories = <String>[];
  List<String> storeStoreLocation = <String>[];
  GlobalKey<FormState> filterStoreKey = GlobalKey<FormState>();
  final TextEditingController categoriesFieldController =
      TextEditingController();
  final SearchRepo _searchRepo = SearchRepo();
  List<Category> searchCategories = <Category>[];

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
    storeStoreLocation.clear();
    updateSelectedStoreRating(0);
    update();
  }
}
