import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/repositories/storerepo.dart';
import 'package:bazaartech/core/service/shared_preferences_key.dart';
import 'package:bazaartech/view/home/model/productmodel.dart';
import 'package:bazaartech/view/home/model/storemodel.dart';
import 'package:bazaartech/widget/customtoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreDetailsController extends GetxController {
  final StoreRepository _storeRepository = StoreRepository();
  final Rx<Store?> store = Rx<Store?>(null);
  final RxString reviewText = ''.obs;
  TextEditingController reviewController = TextEditingController();
  final RxBool isLoadingFetching = false.obs;
  final RxBool isLoadingAddingReview = false.obs;
  final RxList<String> productCategories = <String>[].obs;
  RxInt selectedProductCategoryIndex = 0.obs;
  PageController pageController = PageController();

  void updateSelectedProductCategoryIndex(int index) {
    selectedProductCategoryIndex.value = index;
  }

  Future<void> fetchStore(String id) async {
    try {
      isLoadingFetching.value = true;
      store.value = await _storeRepository.fetchStoreById(id);
      fetchProductCategories();
    } catch (e) {
      ToastUtil.showToast('Failed to load store, ${e.toString()}');
    } finally {
      isLoadingFetching.value = false;
    }
  }

  void fetchProductCategories() {
    if (store.value != null && store.value!.products.isNotEmpty) {
      final categories = store.value!.products.map((p) => p.category).toSet();
      productCategories.assignAll(categories);
    }
  }

  List<Product> get filteredProductsForCurrentCategory {
    if (store.value == null) return [];
    final selectedCategory =
        productCategories[selectedProductCategoryIndex.value];
    return store.value!.products
        .where((product) => product.category == selectedCategory)
        .toList();
  }

  Future<void> callStore() async {
    String phoneNumber = store.value!.storeNumber.toString();
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (!await launchUrl(phoneUri, mode: LaunchMode.externalApplication)) {
      ToastUtil.showToast('Could not launch $phoneUri');
    }
  }

  Future<void> addReview(Store store, String review) async {
    if (review.isEmpty || isLoadingAddingReview.value) return;

    isLoadingAddingReview.value = true;
    try {
      final prefs = await SharedPreferences.getInstance();

      final String? userName =
          prefs.getString(SharedPreferencesKey.userNameKey);
      final String? userImage =
          prefs.getString(SharedPreferencesKey.userImageKey);

      final newReview = Review(
        profilePhoto: userImage != null && userImage.isNotEmpty
            ? userImage
            : AppImages.profilephoto,
        name:
            userName != null && userName.isNotEmpty ? userName : "Current User",
        rating: 5,
        review: review,
      );
      await _storeRepository.addReview(store.id, newReview);

      reviewText.value = '';
      reviewController.clear();
      ToastUtil.showToast('Review added!');
    } catch (e) {
      ToastUtil.showToast('Failed to add review!');
    } finally {
      isLoadingAddingReview.value = false;
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
