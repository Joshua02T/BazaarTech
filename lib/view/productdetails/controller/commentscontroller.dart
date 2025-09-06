import 'package:bazaartech/core/repositories/commentslikerepo.dart';
import 'package:bazaartech/core/repositories/productrepo.dart';
import 'package:bazaartech/view/home/model/commentmodel.dart';
import 'package:bazaartech/widget/customtoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentsController extends GetxController {
  final String id;
  CommentsController(this.id);
  TextEditingController commentController = TextEditingController();
  final ProductRepository _productRepo = ProductRepository();
  final CommentsLikeRepo _commentRepo = CommentsLikeRepo();
  List<Comment> allComments = <Comment>[];
  bool isLoadingFetchingComments = false;
  bool isLoadingAddingComment = false;
  Future<void> fetchCommentsById(String id) async {
    try {
      isLoadingFetchingComments = true;
      update();
      final fetchedComments = await _productRepo.fetchCommentsById(id);
      allComments.clear();
      allComments.assignAll(fetchedComments);
    } catch (e) {
      ToastUtil.showToast('Failed to load comments, ${e.toString()}');
    } finally {
      isLoadingFetchingComments = false;
      update();
    }
  }

  Future<void> addComment(String productId, String body, String rating) async {
    try {
      isLoadingAddingComment = true;
      update();

      final newComment = await _productRepo.addComment(productId, body, rating);

      allComments.insert(0, newComment);

      commentController.clear();

      ToastUtil.showToast("Comment added successfully");
    } catch (e) {
      ToastUtil.showToast(e.toString());
    } finally {
      isLoadingAddingComment = false;
      update();
    }
  }

  Future<void> addLike(String id) async {
    try {
      await _commentRepo.addLike(id);
    } catch (e) {
      ToastUtil.showToast(e.toString());
    } finally {
      isLoadingAddingComment = false;
      update();
    }
  }

  Future<void> toggleLike(String commentId) async {
    // try {
    //   final isLiked =
    //       allComments.firstWhere((c) => c.id == commentId).isLiked;

    //   if (isLiked) {
    //     await deleteLike(commentId);
    //   } else {
    //     await addLike(commentId);
    //   }

    //   await fetchCommentsById(id);
    // } catch (e) {
    //   ToastUtil.showToast("Failed: $e");
    // }
  }

  Future<void> deleteLike(String id) async {
    try {
      await _commentRepo.deleteLike(id);
    } catch (e) {
      ToastUtil.showToast(e.toString());
    } finally {
      isLoadingAddingComment = false;
      update();
    }
  }

  @override
  void onInit() {
    fetchCommentsById(id);
    super.onInit();
  }
}
