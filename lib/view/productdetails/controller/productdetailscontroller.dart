import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/repositories/productrepo.dart';
import 'package:bazaartech/core/service/shared_preferences_key.dart';
import 'package:bazaartech/view/account/controller/accountcontroller.dart';
import 'package:bazaartech/widget/customtoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazaartech/view/home/model/productmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailsController extends GetxController {
  final ProductRepository _productRepo = ProductRepository();
  final Rx<Product?> product = Rx<Product?>(null);
  final RxString commentText = ''.obs;
  TextEditingController commentController = TextEditingController();
  final RxBool isLoadingFetching = false.obs;
  final RxBool isLoadingAddingComment = false.obs;
  final comments = <Comment>[].obs;
  int rating = 0;

  void setRating(int value) {
    rating = value;
    update();
  }

  Future<void> fetchProduct(String id) async {
    try {
      isLoadingFetching.value = true;
      final fetchedProduct = await _productRepo.fetchProductById(id);
      product.value = fetchedProduct;
      comments.assignAll(fetchedProduct!.comments);
    } catch (e) {
      ToastUtil.showToast('Failed to load product, ${e.toString()}');
    } finally {
      isLoadingFetching.value = false;
    }
  }

  void toggleLike(int index) {
    final comment = comments[index];
    if (comment.isLiked == true) {
      comment.likes -= 1;
      comment.isLiked = false;
    } else {
      comment.likes += 1;
      comment.isLiked = true;
    }
    comments[index] = comment;
  }

  Future<void> addComment(Product product, String comment) async {
    if (comment.isEmpty || isLoadingAddingComment.value) return;

    isLoadingAddingComment.value = true;

    try {
      AccountController accController = Get.find<AccountController>();

      final newComment = Comment(
          profilePhoto: accController.profileImageUrl.value.isNotEmpty
              ? accController.profileImageUrl.value
              : AppImages.profilephoto,
          name: accController.nameController.text,
          rating: rating.toDouble(),
          comment: comment,
          likes: 0);

      await _productRepo.addComment(product.id, newComment);
      comments.insert(0, newComment);
      commentText.value = '';
      commentController.clear();
      ToastUtil.showToast('Comment added!');
    } catch (e) {
      ToastUtil.showToast('Failed to add comment!');
    } finally {
      isLoadingAddingComment.value = false;
    }
  }
}
