import 'dart:convert';

import 'package:bazaartech/core/service/link.dart';
import 'package:bazaartech/core/service/my_service.dart';
import 'package:bazaartech/core/service/shared_preferences_key.dart';
import 'package:bazaartech/helper/appconfig.dart';
import 'package:bazaartech/model/commentmodel.dart';
import 'package:bazaartech/view/home/model/productmodel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  Future<List<Product>> fetchProducts() async {
    final myService = Get.find<MyService>();
    final prefs = myService.sharedPreferences;
    final token = prefs.getString(SharedPreferencesKey.tokenKey);

    final response = await http.get(
      Uri.parse(AppLink.getAllProducts),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['data'] != null) {
        return (data['data'] as List).map((json) {
          final product = Product.fromJson(json);

          if (product.image.contains("127.0.0.1")) {
            product.image = product.image
                .replaceAll("http://127.0.0.1:8000", AppConfig.getBaseUrl());
          }

          return product;
        }).toList();
      } else {
        return [];
      }
    } else {
      Get.snackbar("Failed", "Failed to load products: ${response.statusCode}");
      throw Exception("Failed to load products: ${response.statusCode}");
    }
  }

  Future<Product?> fetchProductById(String id) async {
    Product product;
    final myService = Get.find<MyService>();
    final prefs = myService.sharedPreferences;
    final token = prefs.getString(SharedPreferencesKey.tokenKey);

    final response = await http.get(
      Uri.parse('${AppLink.getAllProducts}/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['data'] != null) {
        product = Product.fromJson(data["data"]);

        if (product.image.contains("127.0.0.1")) {
          product.image = product.image
              .replaceAll("http://127.0.0.1:8000", AppConfig.getBaseUrl());
        }

        return product;
      } else {
        return null;
      }
    } else {
      Get.snackbar("Failed", "Failed to load product: ${response.statusCode}");
      throw Exception("Failed to load product: ${response.statusCode}");
    }
  }

  Future<List<Comment>> fetchCommentsById(String id) async {
    final myService = Get.find<MyService>();
    final prefs = myService.sharedPreferences;
    final token = prefs.getString(SharedPreferencesKey.tokenKey);

    final response = await http.get(
      Uri.parse('${AppLink.getAllProducts}/$id/comments'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['data'] != null) {
        return (data['data'] as List).map((json) {
          final comment = Comment.fromJson(json);
          if (comment.profilePhoto != null) {
            if (comment.profilePhoto!.contains("127.0.0.1")) {
              comment.profilePhoto = comment.profilePhoto!
                  .replaceAll("http://127.0.0.1:8000", AppConfig.getBaseUrl());
            }
          }
          return comment;
        }).toList();
      } else {
        return [];
      }
    } else {
      Get.snackbar("Failed", "Failed to load comments: ${response.statusCode}");
      throw Exception("Failed to load comments: ${response.statusCode}");
    }
  }

  Future<Comment> addComment(
      String productId, String body, String rating) async {
    try {
      final myService = Get.find<MyService>();
      final prefs = myService.sharedPreferences;
      final token = prefs.getString(SharedPreferencesKey.tokenKey);

      final response = await http.post(
        Uri.parse('${AppLink.getAllProducts}/$productId/comment'),
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
}
