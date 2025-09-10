import 'package:bazaartech/core/repositories/bazaarrepo.dart';
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
    pageController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    fetchBazaar(id);
    super.onInit();
  }
  // final BazaarRepository _bazaarRepository = BazaarRepository();
  // RxBool isLoadingFetching = false.obs;
  // final Rx<Bazaar?> bazaar = Rx<Bazaar?>(null);
  // final RxList<String> productCategories = <String>[].obs;
  // RxInt selectedProductCategoryIndex = 0.obs;
  // final RxBool isLoadingAddingReview = false.obs;
  // final RxString reviewText = ''.obs;
  // PageController pageController = PageController();
  // TextEditingController reviewController = TextEditingController();
  // final reviews = <Comment>[].obs;
  // int rating = 0;
  // void setRating(int value) {
  //   rating = value;
  //   update();
  // }

  // void updateSelectedProductCategoryIndex(int index) {
  //   selectedProductCategoryIndex.value = index;
  // }

  // Future<void> fetchBazaar(String id) async {
  //   try {
  //     isLoadingFetching.value = true;
  //     bazaar.value = await _bazaarRepository.fetchBazaarById(id);
  //     fetchProductCategories();
  //     reviews.assignAll(bazaar.value!.comments);
  //   } catch (e) {
  //     ToastUtil.showToast('Failed to load bazaar, ${e.toString()}');
  //   } finally {
  //     isLoadingFetching.value = false;
  //   }
  // }

  // void fetchProductCategories() {
  //   if (bazaar.value != null && bazaar.value!.products.isNotEmpty) {
  //     final categories = bazaar.value!.products.map((p) => p.category).toSet();
  //     productCategories.assignAll(categories);
  //   }
  // }

  // void toggleLike(int index) {
  //   final review = reviews[index];
  //   if (review.isLiked == true) {
  //     review.likes -= 1;
  //     review.isLiked = false;
  //   } else {
  //     review.likes += 1;
  //     review.isLiked = true;
  //   }
  //   reviews[index] = review;
  // }

  // Future<void> addReview(Bazaar bazaar, String review) async {
  //   if (review.isEmpty || isLoadingAddingReview.value) return;

  //   isLoadingAddingReview.value = true;
  //   try {
  //     AccountController accController = Get.find<AccountController>();

  //     final newReview = Comment(
  //         isLiked: false,
  //         id: 0,
  //         profilePhoto: accController.profileImageUrl.value.isNotEmpty
  //             ? accController.profileImageUrl.value
  //             : AppImages.profilephoto,
  //         name: accController.nameController.text,
  //         userId: 4,
  //         rating: rating,
  //         comment: review,
  //         likes: 0);
  //     await _bazaarRepository.(bazaar.id, newReview);
  //     reviews.insert(0, newReview);
  //     reviewText.value = '';
  //     reviewController.clear();
  //     ToastUtil.showToast('Review added!');
  //   } catch (e) {
  //     ToastUtil.showToast('Failed to add review!');
  //   } finally {
  //     isLoadingAddingReview.value = false;
  //   }
  // }

  // List<Product> get filteredProductsForCurrentCategory {
  //   if (bazaar.value == null) return [];
  //   final selectedCategory =
  //       productCategories[selectedProductCategoryIndex.value];
  //   return bazaar.value!.products
  //       .where((product) => product.category == selectedCategory)
  //       .toList();
  // }

  // @override
  // void onClose() {
  //   pageController.dispose();
  //   super.onClose();
  // }
}
