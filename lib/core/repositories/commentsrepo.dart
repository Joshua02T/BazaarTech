import 'dart:convert';

import 'package:bazaartech/core/service/link.dart';
import 'package:bazaartech/core/service/my_service.dart';
import 'package:bazaartech/core/service/shared_preferences_key.dart';
import 'package:bazaartech/helper/appconfig.dart';
import 'package:bazaartech/model/commentmodel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CommentsRepo {
  Future<Comment> addComment(String id, String body, String rating) async {
    try {
      final myService = Get.find<MyService>();
      final prefs = myService.sharedPreferences;
      final token = prefs.getString(SharedPreferencesKey.tokenKey);

      final response = await http.post(
        Uri.parse('${AppLink.getAllProducts}/$id/comment'),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        body: {"body": body, "rating": rating},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        if (data["success"] == true) {
          final Comment createdComment = Comment.fromJson(data["data"]);
          if (createdComment.profilePhoto != null) {
            if (createdComment.profilePhoto!.contains("127.0.0.1")) {
              createdComment.profilePhoto = createdComment.profilePhoto!
                  .replaceAll("http://127.0.0.1:8000", AppConfig.getBaseUrl());
            }
          }
          return createdComment;
        } else {
          throw Exception(data["message"] ?? "Failed to create comment");
        }
      } else {
        Get.snackbar('Error', response.statusCode.toString());
        throw Exception("Something went wrong (${response.statusCode})");
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      throw Exception("Error: $e");
    }
  }

  Future<Comment> editComment(String id, String body, String rating) async {
    try {
      final myService = Get.find<MyService>();
      final prefs = myService.sharedPreferences;
      final token = prefs.getString(SharedPreferencesKey.tokenKey);

      final response = await http.put(
        Uri.parse('${AppLink.comments}/$id'),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        body: {"body": body, "rating": rating},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        if (data["success"] == true) {
          final Comment updatedComment = Comment.fromJson(data["data"]);
          if (updatedComment.profilePhoto != null) {
            if (updatedComment.profilePhoto!.contains("127.0.0.1")) {
              updatedComment.profilePhoto = updatedComment.profilePhoto!
                  .replaceAll("http://127.0.0.1:8000", AppConfig.getBaseUrl());
            }
          }
          return updatedComment;
        } else {
          throw Exception(data["message"] ?? "Failed to create comment");
        }
      } else {
        Get.snackbar('Error', response.statusCode.toString());
        throw Exception("Something went wrong (${response.statusCode})");
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      throw Exception("Error: $e");
    }
  }

  Future<bool> deleteComment(String id) async {
    try {
      final myService = Get.find<MyService>();
      final prefs = myService.sharedPreferences;
      final token = prefs.getString(SharedPreferencesKey.tokenKey);

      final response = await http.delete(
        Uri.parse('${AppLink.comments}/$id'),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data["success"] == true) {
          return true;
        } else {
          throw Exception(data["message"] ?? "Failed to delete comment");
        }
      } else {
        throw Exception("Something went wrong (${response.statusCode})");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return false;
    }
  }

  Future<Comment> addLike(String id) async {
    final myService = Get.find<MyService>();
    final prefs = myService.sharedPreferences;
    final token = prefs.getString(SharedPreferencesKey.tokenKey);

    final response = await http.post(
      Uri.parse('${AppLink.comments}/$id/like'),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body)["data"];
      Comment newComment = Comment.fromJson(data);
      if (newComment.profilePhoto != null) {
        if (newComment.profilePhoto!.contains("127.0.0.1")) {
          newComment.profilePhoto = newComment.profilePhoto!
              .replaceAll("http://127.0.0.1:8000", AppConfig.getBaseUrl());
        }
      }

      return newComment;
    } else {
      throw Exception("Something went wrong (${response.statusCode})");
    }
  }

  Future<Comment> deleteLike(String id) async {
    final myService = Get.find<MyService>();
    final prefs = myService.sharedPreferences;
    final token = prefs.getString(SharedPreferencesKey.tokenKey);

    final response = await http.delete(
      Uri.parse('${AppLink.comments}/$id/like'),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body)["data"];
      Comment newComment = Comment.fromJson(data);
      if (newComment.profilePhoto != null) {
        if (newComment.profilePhoto!.contains("127.0.0.1")) {
          newComment.profilePhoto = newComment.profilePhoto!
              .replaceAll("http://127.0.0.1:8000", AppConfig.getBaseUrl());
        }
      }
      return newComment;
    } else {
      throw Exception("Something went wrong (${response.statusCode})");
    }
  }
}
