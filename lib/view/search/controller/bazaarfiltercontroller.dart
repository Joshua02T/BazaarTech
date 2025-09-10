import 'package:bazaartech/core/repositories/searchrepo.dart';
import 'package:bazaartech/model/categorymodel.dart';
import 'package:bazaartech/widget/customtoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BazaarFilterController extends GetxController {
  int selectedIndexBazaarStatus = 1;
  List<String> bazaarStoreLocation = <String>[];
  List<String> selectedCategories = <String>[];
  final TextEditingController categoriesFieldController =
      TextEditingController();
  final TextEditingController storesFieldController = TextEditingController();
  final TextEditingController bazaarPastDate = TextEditingController();
  final TextEditingController bazaarUpComingDate = TextEditingController();
  GlobalKey<FormState> filterBazaarKey = GlobalKey<FormState>();
  final SearchRepo _searchRepo = SearchRepo();
  List<Category> searchCategories = <Category>[];

  Future<void> fetchBazaarCategories(String item, String body) async {
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

  void updateSelectedIndexBazaarStatus(int index) {
    selectedIndexBazaarStatus = index;
    update();
  }

  void resetDefaultsBazaarFilter() {
    bazaarPastDate.clear();
    bazaarUpComingDate.clear();
    selectedCategories.clear();
    bazaarStoreLocation.clear();
    updateSelectedIndexBazaarStatus(1);
    update();
  }

  String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Select a date';
    }
    return null;
  }

  void pickUpComingDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime tomorrow = now.add(const Duration(days: 1));
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: tomorrow,
      firstDate: tomorrow,
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      bazaarUpComingDate.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }

  void pickPastDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime yesterday = now.subtract(const Duration(days: 1));

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: yesterday,
      firstDate: DateTime(1900),
      lastDate: yesterday,
    );

    if (picked != null) {
      bazaarPastDate.text = "${picked.day}/${picked.month}/${picked.year}";
    }
  }
}
