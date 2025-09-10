import 'package:bazaartech/core/repositories/searchrepo.dart';
import 'package:bazaartech/model/categorymodel.dart';
import 'package:bazaartech/widget/customtoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterSearchController extends GetxController {
  List<Category> searchCategories = <Category>[];
  final SearchRepo _searchRepo = SearchRepo();
  Future<void> fetchCategories(String item, String body) async {
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

  int selectedProductRating = 0;
  int selectedStoreRating = 0;

  int selectedIndexBazaarStatus = 1;
  final TextEditingController minPrice = TextEditingController();
  final TextEditingController maxPrice = TextEditingController();
  final TextEditingController bazaarPastDate = TextEditingController();
  final TextEditingController bazaarUpComingDate = TextEditingController();

  GlobalKey<FormState> filterKey = GlobalKey<FormState>();

  List<String> selectedProductCategories = <String>[];
  List<String> selectedStoreCategories = <String>[];
  List<String> selectedBazaarCategories = <String>[];

  final TextEditingController categoriesFieldController =
      TextEditingController();
  List<String> productStoreLocation = <String>[];
  List<String> storeStoreLocation = <String>[];
  List<String> bazaarStoreLocation = <String>[];

  final TextEditingController storesFieldController = TextEditingController();
  RxBool isMinPriceEmpty = true.obs;

  void updateSelectedProductRating(int index) {
    selectedProductRating = index;
    update();
  }

  void updateSelectedStoreRating(int index) {
    selectedStoreRating = index;
    update();
  }

  void updateSelectedIndexBazaarStatus(int index) {
    selectedIndexBazaarStatus = index;
    update();
  }

  void resetDefaultsProductFilter() {
    minPrice.clear();
    maxPrice.clear();
    selectedProductCategories.clear();
    productStoreLocation.clear();
    updateSelectedProductRating(0);
  }

  void resetDefaultsStoreFilter() {
    selectedStoreCategories.clear();
    storeStoreLocation.clear();
    updateSelectedStoreRating(0);
  }

  void resetDefaultsBazaarFilter() {
    bazaarPastDate.clear();
    bazaarUpComingDate.clear();
    selectedBazaarCategories.clear();
    bazaarStoreLocation.clear();
    updateSelectedIndexBazaarStatus(1);
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

  String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Select a date';
    }
    return null;
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

  @override
  void onInit() {
    minPrice.addListener(() {
      isMinPriceEmpty.value = minPrice.text.trim().isEmpty;
    });
    //   debounce(searchText, (val) {
    //   fetchCategories(val, body);
    // }, time: const Duration(milliseconds: 500));

    super.onInit();
  }
}
