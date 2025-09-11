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
  Future<List<Product>> fetchProducts(
    String name,
    String minRating,
    String minPrice,
    String maxPrice,
    List<int> categoryIds,
  ) async {
    final myService = Get.find<MyService>();
    final prefs = myService.sharedPreferences;
    final token = prefs.getString(SharedPreferencesKey.tokenKey);

    // Base query
    final queryParams = {
      'name': name,
      'min_rating': minRating,
      'price_min': minPrice,
      'price_max': maxPrice,
    };

    // Start building uri
    var uri = Uri.parse(AppLink.getAllProducts).replace(
      queryParameters: queryParams,
    );

    // If categoryIds is not empty, append them manually
    if (categoryIds.isNotEmpty) {
      final extra = categoryIds.map((id) => 'category_ids[]=$id').join('&');
      final url = uri.toString() + "&$extra";
      uri = Uri.parse(url);
    }

    final response = await http.get(
      uri,
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

  // Future<List<Product>> fetchProducts(
  //   String name,
  //   String minRating,
  //   String minPrice,
  //   String maxPrice,
  //   List<int> categoryIds,
  // ) async {
  //   final myService = Get.find<MyService>();
  //   final prefs = myService.sharedPreferences;
  //   final token = prefs.getString(SharedPreferencesKey.tokenKey);

  //   final uri = Uri.parse(AppLink.getAllProducts).replace(
  //     queryParameters: {
  //       'name': name,
  //       'min_rating': minRating,
  //       'price_min': minPrice,
  //       "price_max": maxPrice
  //     },
  //     queryParametersAll: {
  //     'category_ids[]': categoryIds.map((id) => id.toString()).toList(),
  //   },
  //   );

  //   final response = await http.get(
  //     uri,
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     },
  //   );
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);

  //     if (data['data'] != null) {
  //       return (data['data'] as List).map((json) {
  //         final product = Product.fromJson(json);

  //         if (product.image.contains("127.0.0.1")) {
  //           product.image = product.image
  //               .replaceAll("http://127.0.0.1:8000", AppConfig.getBaseUrl());
  //         }

  //         return product;
  //       }).toList();
  //     } else {
  //       return [];
  //     }
  //   } else {
  //     Get.snackbar("Failed", "Failed to load products: ${response.statusCode}");
  //     throw Exception("Failed to load products: ${response.statusCode}");
  //   }
  // }

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
}
