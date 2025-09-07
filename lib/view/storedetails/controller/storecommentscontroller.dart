import 'package:bazaartech/core/repositories/commentslikerepo.dart';
import 'package:bazaartech/core/repositories/storerepo.dart';
import 'package:bazaartech/model/commentmodel.dart';
import 'package:bazaartech/widget/customtoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreCommentsController extends GetxController {
  final String id;
  StoreCommentsController(this.id);
  TextEditingController commentController = TextEditingController();
  final StoreRepository _storeRepository = StoreRepository();
  final CommentsLikeRepo _commentRepo = CommentsLikeRepo();
  List<Comment> allComments = <Comment>[];
  bool isLoadingFetchingComments = false;
  bool isLoadingAddingComment = false;
  Future<void> fetchCommentsById(String id) async {
    try {
      isLoadingFetchingComments = true;
      update();
      final fetchedComments = await _storeRepository.fetchCommentsById(id);
      allComments.clear();
      allComments.assignAll(fetchedComments);
    } catch (e) {
      ToastUtil.showToast('Failed to load comments, ${e.toString()}');
    } finally {
      isLoadingFetchingComments = false;
      update();
    }
  }

  Future<void> addComment(String storeId, String body, String rating) async {
    try {
      isLoadingAddingComment = true;
      update();

      final newComment =
          await _storeRepository.addComment(storeId, body, rating);

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

  Future<void> addLike(String commentId) async {
    try {
      final updatedComment = await _commentRepo.addLike(commentId);

      int index = allComments.indexWhere((c) => c.id == updatedComment.id);
      if (index != -1) {
        allComments[index] = updatedComment;
      }

      ToastUtil.showToast('You liked the comment!');
      update();
    } catch (e) {
      ToastUtil.showToast(e.toString());
    }
  }

  Future<void> deleteLike(String commentId) async {
    try {
      final updatedComment = await _commentRepo.deleteLike(commentId);

      int index = allComments.indexWhere((c) => c.id == updatedComment.id);
      if (index != -1) {
        allComments[index] = updatedComment;
      }

      ToastUtil.showToast('You removed the like!');
      update();
    } catch (e) {
      ToastUtil.showToast(e.toString());
    }
  }

  Future<void> toggleLike(String commentId) async {
    try {
      final comment =
          allComments.firstWhere((c) => c.id.toString() == commentId);

      if (comment.isLiked == true) {
        await deleteLike(commentId);
      } else {
        await addLike(commentId);
      }
    } catch (e) {
      ToastUtil.showToast("Failed: $e");
    }
  }

  @override
  void onInit() {
    fetchCommentsById(id);
    super.onInit();
  }
}
