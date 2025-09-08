import 'package:bazaartech/core/repositories/commentsrepo.dart';
import 'package:bazaartech/core/repositories/productrepo.dart';
import 'package:bazaartech/model/commentmodel.dart';
import 'package:bazaartech/widget/customtoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentsController extends GetxController {
  final String id;
  CommentsController(this.id);
  TextEditingController commentController = TextEditingController();
  final ProductRepository _productRepo = ProductRepository();
  final CommentsRepo _commentRepo = CommentsRepo();
  List<Comment> allComments = <Comment>[];
  bool isLoadingFetchingComments = false;
  bool isLoadingAddingComment = false;
  bool isEditing = false;
  int? editingCommentId;
  FocusNode commentFocusNode = FocusNode();

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

      final newComment = await _commentRepo.addComment(productId, body, rating);

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

  Future<void> editComment(String id, String body, String rating) async {
    try {
      isLoadingAddingComment = true;
      update();
      final updatedComment = await _commentRepo.editComment(id, body, rating);

      int index = allComments.indexWhere((c) => c.id.toString() == id);
      if (index != -1) {
        allComments[index] = updatedComment;
      }

      isEditing = false;
      editingCommentId = null;
      commentController.clear();

      ToastUtil.showToast("Comment updated successfully");
      update();
    } catch (e) {
      ToastUtil.showToast("Failed to update: $e");
    } finally {
      isLoadingAddingComment = false;
      update();
    }
  }

  void startEditing(Comment comment) {
    isEditing = true;
    editingCommentId = comment.id;
    commentController.text = comment.comment;
    update();

    Future.delayed(const Duration(milliseconds: 100), () {
      commentFocusNode.requestFocus();
    });
  }

  Future<void> deleteComment(String commentId) async {
    try {
      final success = await _commentRepo.deleteComment(commentId);

      if (success) {
        allComments.removeWhere((c) => c.id.toString() == commentId);
        ToastUtil.showToast("Comment deleted successfully");
        update();
      }
    } catch (e) {
      ToastUtil.showToast("Failed to delete comment: $e");
    }
  }

  @override
  void onInit() {
    fetchCommentsById(id);
    super.onInit();
  }
}
