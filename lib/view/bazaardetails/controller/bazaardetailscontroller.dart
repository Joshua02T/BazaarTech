import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/repositories/bazaarrepo.dart';
import 'package:bazaartech/core/service/shared_preferences_key.dart';
import 'package:bazaartech/view/home/model/bazaarmodel.dart';
import 'package:bazaartech/view/home/model/productmodel.dart';
import 'package:bazaartech/view/home/model/storemodel.dart';
import 'package:bazaartech/widget/customtoast.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BazaarDetailsController extends GetxController {
  final BazaarRepository _bazaarRepository = BazaarRepository();
  RxBool isLoadingFetching = false.obs;
  final Rx<Bazaar?> bazaar = Rx<Bazaar?>(null);
  final RxList<String> productCategories = <String>[].obs;
  RxInt selectedProductCategoryIndex = 0.obs;
  final RxBool isLoadingAddingReview = false.obs;
  final RxString reviewText = ''.obs;
  PageController pageController = PageController();
  TextEditingController reviewController = TextEditingController();
  final reviews = <Review>[].obs;
  int rating = 0;
  void setRating(int value) {
    rating = value;
    update();
  }

  void updateSelectedProductCategoryIndex(int index) {
    selectedProductCategoryIndex.value = index;
  }

  Future<void> fetchBazaar(String id) async {
    try {
      isLoadingFetching.value = true;
      bazaar.value = await _bazaarRepository.fetchBazaarById(id);
      fetchProductCategories();
      reviews.assignAll(bazaar.value!.reviews);
    } catch (e) {
      ToastUtil.showToast('Failed to load bazaar, ${e.toString()}');
    } finally {
      isLoadingFetching.value = false;
    }
  }

  void fetchProductCategories() {
    if (bazaar.value != null && bazaar.value!.products.isNotEmpty) {
      final categories = bazaar.value!.products.map((p) => p.category).toSet();
      productCategories.assignAll(categories);
    }
  }

  void toggleLike(int index) {
    final review = reviews[index];
    if (review.isLiked == true) {
      review.likes -= 1;
      review.isLiked = false;
    } else {
      review.likes += 1;
      review.isLiked = true;
    }
    reviews[index] = review;
  }

  Future<void> addReview(Bazaar bazaar, String review) async {
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
          name: userName != null && userName.isNotEmpty
              ? userName
              : "Current User",
          rating: 5,
          review: review,
          likes: 0);
      await _bazaarRepository.addReview(bazaar.id, newReview);
      reviews.insert(0, newReview);
      reviewText.value = '';
      reviewController.clear();
      ToastUtil.showToast('Review added!');
    } catch (e) {
      ToastUtil.showToast('Failed to add review!');
    } finally {
      isLoadingAddingReview.value = false;
    }
  }

  List<Product> get filteredProductsForCurrentCategory {
    if (bazaar.value == null) return [];
    final selectedCategory =
        productCategories[selectedProductCategoryIndex.value];
    return bazaar.value!.products
        .where((product) => product.category == selectedCategory)
        .toList();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
