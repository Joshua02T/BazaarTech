import 'package:bazaartech/core/repositories/searchrepo.dart';
import 'package:bazaartech/model/categorymodel.dart';
import 'package:bazaartech/widget/customtoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BazaarFilterController extends GetxController {
  int? selectedIndexBazaarStatus;
  List<String> itemLocation = <String>[];
  List<Category> selectedCategories = <Category>[];
  final TextEditingController categoriesFieldController =
      TextEditingController();
  final TextEditingController locationsFieldController =
      TextEditingController();
  final TextEditingController bazaarPastDate = TextEditingController();
  final TextEditingController bazaarUpComingDate = TextEditingController();
  final SearchRepo _searchRepo = SearchRepo();
  List<Category> searchCategories = <Category>[];

  List<int> getSelectedCategoryIds() {
    return selectedCategories.map((c) => c.id).toList();
  }

  String getStatus() {
    return selectedIndexBazaarStatus == 0
        ? 'past'
        : selectedIndexBazaarStatus == 1
            ? 'ongoing'
            : selectedIndexBazaarStatus == 2
                ? 'upcoming'
                : '';
  }

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
    itemLocation.clear();
    updateSelectedIndexBazaarStatus(4);
    update();
  }

  void pickUpComingDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime tomorrow = now.add(const Duration(days: 1));

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: tomorrow,
      firstDate: tomorrow,
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime fullDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        String formattedDate =
            DateFormat('yyyy-MM-dd HH:mm:ss').format(fullDateTime);

        bazaarUpComingDate.text = formattedDate;
      }
    }
  }

  void pickPastDate(BuildContext context) async {
    final DateTime now = DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1900),
      lastDate: now,
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime fullDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        String formattedDate =
            DateFormat('yyyy-MM-dd HH:mm:ss').format(fullDateTime);

        bazaarPastDate.text = formattedDate;
      }
    }
  }
}
