import 'dart:convert';
import 'package:bazaartech/core/service/link.dart';
import 'package:bazaartech/core/service/my_service.dart';
import 'package:bazaartech/core/service/shared_preferences_key.dart';
import 'package:bazaartech/helper/appconfig.dart';
import 'package:bazaartech/view/home/model/bazaarmodel.dart';
import 'package:bazaartech/view/home/model/productmodel.dart';
import 'package:bazaartech/view/home/model/storemodel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FavoriteRepository {
  Future<bool> toggleFavorite(String kind, String id) async {
    final myService = Get.find<MyService>();
    final prefs = myService.sharedPreferences;
    final token = prefs.getString(SharedPreferencesKey.tokenKey);

    final Uri url = kind == 'product'
        ? Uri.parse('${AppLink.getAllProducts}/$id/favorite')
        : kind == 'store'
            ? Uri.parse('${AppLink.getAllStores}/$id/favorite')
            : Uri.parse('${AppLink.getAllBazaars}/$id/favorite');

    final response = await http.post(
      url,
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final body = jsonDecode(response.body);
      final isFavorite = body["data"]["isFavorite"] as bool;
      return isFavorite;
    } else {
      throw Exception("Something went wrong (${response.statusCode})");
    }
  }

  Future<List<Product>> fetchProductFav() async {
    final myService = Get.find<MyService>();
    final prefs = myService.sharedPreferences;
    final token = prefs.getString(SharedPreferencesKey.tokenKey);
    final response = await http.get(
      Uri.parse('${AppLink.fetchFavorite}/products'),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
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
      Get.snackbar("Failed",
          "Failed to load products in favorites: ${response.statusCode}");
      throw Exception(
          "Failed to load products in favorites: ${response.statusCode}");
    }
  }

  Future<List<Store>> fetchStoreFav() async {
    final myService = Get.find<MyService>();
    final prefs = myService.sharedPreferences;
    final token = prefs.getString(SharedPreferencesKey.tokenKey);
    final response = await http.get(
      Uri.parse('${AppLink.fetchFavorite}/stores'),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['data'] != null) {
        return (data['data'] as List).map((json) {
          final store = Store.fromJson(json);

          if (store.image.contains("127.0.0.1")) {
            store.image = store.image
                .replaceAll("http://127.0.0.1:8000", AppConfig.getBaseUrl());
          }

          return store;
        }).toList();
      } else {
        return [];
      }
    } else {
      Get.snackbar("Failed",
          "Failed to load stores in favorites: ${response.statusCode}");
      throw Exception(
          "Failed to load stores in favorites: ${response.statusCode}");
    }
  }

  Future<List<Bazaar>> fetchBazaarFav() async {
    final myService = Get.find<MyService>();
    final prefs = myService.sharedPreferences;
    final token = prefs.getString(SharedPreferencesKey.tokenKey);
    final response = await http.get(
      Uri.parse('${AppLink.fetchFavorite}/bazaars'),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['data'] != null) {
        return (data['data'] as List).map((json) {
          final bazaar = Bazaar.fromJson(json);

          if (bazaar.image.contains("127.0.0.1")) {
            bazaar.image = bazaar.image
                .replaceAll("http://127.0.0.1:8000", AppConfig.getBaseUrl());
          }

          return bazaar;
        }).toList();
      } else {
        return [];
      }
    } else {
      Get.snackbar("Failed",
          "Failed to load bazaars in favorites: ${response.statusCode}");
      throw Exception(
          "Failed to load bazaars in favorites: ${response.statusCode}");
    }
  }
}
