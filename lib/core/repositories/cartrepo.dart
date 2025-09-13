import 'dart:convert';

import 'package:bazaartech/core/service/link.dart';
import 'package:bazaartech/core/service/my_service.dart';
import 'package:bazaartech/core/service/shared_preferences_key.dart';
import 'package:bazaartech/helper/appconfig.dart';
import 'package:bazaartech/view/cart/models/cartitemmodel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CartRepo {
  Future<CartItem> addToCart(int productId, {String? isFromBazaar}) async {
    try {
      final myService = Get.find<MyService>();
      final prefs = myService.sharedPreferences;
      final token = prefs.getString(SharedPreferencesKey.tokenKey);
      final Map<String, String> body = {};
      if (isFromBazaar != null) {
        body["isFromBazaar"] = isFromBazaar.toString();
      } else {
        body["isFromBazaar"] = '';
      }

      final response = await http.post(
        Uri.parse('${AppLink.addToCart}/$productId'),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        if (data["success"] == true) {
          final CartItem createdCartItem = CartItem.fromJson(data["data"]);

          if (createdCartItem.product.image.contains("127.0.0.1")) {
            createdCartItem.product.image = createdCartItem.product.image
                .replaceAll("http://127.0.0.1:8000", AppConfig.getBaseUrl());
          }

          return createdCartItem;
        } else {
          throw Exception(data["message"] ?? "Failed to add to cart");
        }
      } else {
        Get.snackbar('Error', response.statusCode.toString());
        throw Exception("Something went wrong (${response.statusCode})");
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', e.toString());
      throw Exception("Error: $e");
    }
  }

  Future<List<CartItem>> fetchCartItems() async {
    final myService = Get.find<MyService>();
    final prefs = myService.sharedPreferences;
    final token = prefs.getString(SharedPreferencesKey.tokenKey);

    final response = await http.get(
      Uri.parse(AppLink.getCartItmes),
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
          final cartItem = CartItem.fromJson(json);

          if (cartItem.product.image.contains("127.0.0.1")) {
            cartItem.product.image = cartItem.product.image
                .replaceAll("http://127.0.0.1:8000", AppConfig.getBaseUrl());
          }

          return cartItem;
        }).toList();
      } else {
        return [];
      }
    } else {
      Get.snackbar(
          "Failed", "Failed to load cart items: ${response.statusCode}");
      throw Exception("Failed to load cart items: ${response.statusCode}");
    }
  }

  Future<CartItem> decreaseCartQuantity(String id) async {
    try {
      final myService = Get.find<MyService>();
      final prefs = myService.sharedPreferences;
      final token = prefs.getString(SharedPreferencesKey.tokenKey);

      final response = await http
          .post(Uri.parse('${AppLink.decreseCartItemQuantity}/$id'), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        if (data["success"] == true) {
          final CartItem updatedCartItem = CartItem.fromJson(data["data"]);

          if (updatedCartItem.product.image.contains("127.0.0.1")) {
            updatedCartItem.product.image = updatedCartItem.product.image
                .replaceAll("http://127.0.0.1:8000", AppConfig.getBaseUrl());
          }

          return updatedCartItem;
        } else {
          throw Exception(
              data["message"] ?? "Failed to decrease item quantity");
        }
      } else {
        Get.snackbar('Error', response.statusCode.toString());
        throw Exception("Something went wrong (${response.statusCode})");
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', e.toString());
      throw Exception("Error: $e");
    }
  }

  Future<bool> deleteCartItem(String id) async {
    try {
      final myService = Get.find<MyService>();
      final prefs = myService.sharedPreferences;
      final token = prefs.getString(SharedPreferencesKey.tokenKey);

      final response = await http.delete(
        Uri.parse('${AppLink.decreseCartItemQuantity}/$id'),
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
}
