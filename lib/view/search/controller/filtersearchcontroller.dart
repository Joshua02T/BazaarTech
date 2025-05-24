import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterSearchController extends GetxController {
  RxInt selectedProductRating = 0.obs;
  RxInt selectedStoreRating = 0.obs;

  RxInt selectedIndexBazaarStatus = 1.obs;
  final TextEditingController minPrice = TextEditingController();
  final TextEditingController maxPrice = TextEditingController();
  final TextEditingController bazaarPastDate = TextEditingController();
  final TextEditingController bazaarUpComingDate = TextEditingController();

  GlobalKey<FormState> filterKey = GlobalKey<FormState>();

  RxList<String> productCategories = <String>[].obs;
  RxList<String> storeCategories = <String>[].obs;
  RxList<String> bazaarCategories = <String>[].obs;

  final TextEditingController categoriesFieldController =
      TextEditingController();
  RxList<String> productStores = <String>[].obs;
  RxList<String> storeStores = <String>[].obs;
  RxList<String> bazaarStores = <String>[].obs;

  final TextEditingController storesFieldController = TextEditingController();
  RxBool isMinPriceEmpty = true.obs;

  void addProductCategory(String category) {
    if (category.isNotEmpty && !productCategories.contains(category)) {
      productCategories.add(category);
      categoriesFieldController.clear();
    }
  }

  void removeProductCategory(String category) {
    productCategories.remove(category);
  }

  void addStoreCategory(String category) {
    if (category.isNotEmpty && !storeCategories.contains(category)) {
      storeCategories.add(category);
      categoriesFieldController.clear();
    }
  }

  void removeStoreCategory(String category) {
    storeCategories.remove(category);
  }

  void addBazaarCategory(String category) {
    if (category.isNotEmpty && !bazaarCategories.contains(category)) {
      bazaarCategories.add(category);
      categoriesFieldController.clear();
    }
  }

  void removeBazaarCategory(String category) {
    bazaarCategories.remove(category);
  }

  void addProductStore(String store) {
    if (store.isNotEmpty && !productStores.contains(store)) {
      productStores.add(store);
      storesFieldController.clear();
    }
  }

  void removeProductStore(String store) {
    productStores.remove(store);
  }

  void addStoreStore(String store) {
    if (store.isNotEmpty && !storeStores.contains(store)) {
      storeStores.add(store);
      storesFieldController.clear();
    }
  }

  void removeStoreStore(String store) {
    storeStores.remove(store);
  }

  void addBazaarStore(String store) {
    if (store.isNotEmpty && !bazaarStores.contains(store)) {
      bazaarStores.add(store);
      storesFieldController.clear();
    }
  }

  void removeBazaarStore(String store) {
    bazaarStores.remove(store);
  }

  void updateSelectedProductRating(int index) {
    selectedProductRating.value = index;
  }

  void updateSelectedStoreRating(int index) {
    selectedStoreRating.value = index;
  }

  void updateSelectedIndexBazaarStatus(int index) {
    selectedIndexBazaarStatus.value = index;
  }

  void resetDefaultsProductFilter() {
    minPrice.clear();
    maxPrice.clear();
    productCategories.clear();
    productStores.clear();
    updateSelectedProductRating(0);
  }

  void resetDefaultsStoreFilter() {
    storeCategories.clear();
    storeStores.clear();
    updateSelectedStoreRating(0);
  }

  void resetDefaultsBazaarFilter() {
    bazaarPastDate.clear();
    bazaarUpComingDate.clear();
    bazaarCategories.clear();
    bazaarStores.clear();
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
      return 'Enter Maximum Price';
    }
    if (value.trim().startsWith('0') && value.trim().length > 1) {
      return 'Price cannot start with zero';
    }

    try {
      double maxPriceValue = double.parse(value.trim());
      if (maxPriceValue < 0) {
        return 'Enter Valid Price';
      }
    } catch (e) {
      return 'Invalid Price Format';
    }

    if (minPrice.text.trim().isEmpty) {
      return '';
    }

    try {
      double minPriceValue = double.parse(minPrice.text.trim());
      double maxPriceValue = double.parse(value.trim());

      if (maxPriceValue < minPriceValue) {
        return 'Enter Bigger Max Price';
      }
    } catch (e) {
      return 'Invalid Price Format';
    }
    return null;
  }

  @override
  void onInit() {
    minPrice.addListener(() {
      isMinPriceEmpty.value = minPrice.text.trim().isEmpty;
    });

    super.onInit();
  }
}
