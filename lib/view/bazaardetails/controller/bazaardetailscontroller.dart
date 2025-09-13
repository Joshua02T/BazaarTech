import 'package:bazaartech/core/repositories/bazaarrepo.dart';
import 'package:bazaartech/core/service/my_service.dart';
import 'package:bazaartech/model/categorymodel.dart';
import 'package:bazaartech/view/home/model/bazaarmodel.dart';
import 'package:bazaartech/model/commentmodel.dart';
import 'package:bazaartech/view/home/model/productmodel.dart';
import 'package:bazaartech/widget/customtoast.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class BazaarDetailsController extends GetxController {
  final String id;
  BazaarDetailsController(this.id);
  final BazaarRepository _bazaarRepository = BazaarRepository();
  Bazaar? bazaar;
  bool isLoadingFetching = false;
  final List<Category> productCategories = <Category>[];
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

  Future<void> fetchBazaar(String id) async {
    try {
      isLoadingFetching = true;
      update();
      final fetchedBazaar = await _bazaarRepository.fetchBazaarById(id);
      bazaar = fetchedBazaar;
      comments.assignAll(fetchedBazaar!.comments);
      fetchProductCategories();
    } catch (e) {
      ToastUtil.showToast('Failed to load bazaar, ${e.toString()}');
    } finally {
      isLoadingFetching = false;
      update();
    }
  }

  void fetchProductCategories() {
    if (bazaar != null) {
      productCategories.clear();

      for (Category c in bazaar!.categories) {
        productCategories.add(c);
      }

      selectedProductCategoryIndex = 0;
      update();
    }
  }

  List<Product> get filteredProductsForCurrentCategory {
    if (bazaar == null) return [];

    final selectedCategory =
        productCategories[selectedProductCategoryIndex].name;

    return bazaar!.products
        .where((p) => p.category == selectedCategory)
        .toList();
  }

  @override
  void onClose() {
    Get.find<MyService>().isFromBazaar = null;
    pageController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    fetchBazaar(id);
    Get.find<MyService>().isFromBazaar = id;
    super.onInit();
  }
}
