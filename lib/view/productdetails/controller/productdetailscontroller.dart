import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/core/repositories/productrepo.dart';
import 'package:bazaartech/core/service/shared_preferences_key.dart';
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

  Future<void> fetchProduct(String id) async {
    try {
      isLoadingFetching.value = true;
      product.value = await _productRepo.fetchProductById(id);
    } catch (e) {
      ToastUtil.showToast('Failed to load product, ${e.toString()}');
    } finally {
      isLoadingFetching.value = false;
    }
  }

  Future<void> addComment(Product product, String comment) async {
    if (comment.isEmpty || isLoadingAddingComment.value) return;

    isLoadingAddingComment.value = true;

    try {
      final prefs = await SharedPreferences.getInstance();

      final String? userName =
          prefs.getString(SharedPreferencesKey.userNameKey);
      final String? userImage =
          prefs.getString(SharedPreferencesKey.userImageKey);

      final newComment = Comment(
        profilePhoto: userImage != null && userImage.isNotEmpty
            ? userImage
            : AppImages.profilephoto,
        name:
            userName != null && userName.isNotEmpty ? userName : "Current User",
        rating: 5,
        comment: comment,
      );

      await _productRepo.addComment(product.id, newComment);

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
