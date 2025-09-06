import 'dart:convert';

import 'package:bazaartech/core/service/link.dart';
import 'package:bazaartech/core/service/my_service.dart';
import 'package:bazaartech/core/service/shared_preferences_key.dart';
import 'package:bazaartech/helper/appconfig.dart';
import 'package:bazaartech/view/home/model/storemodel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class StoreRepository {
  Future<List<Store>> fetchStores() async {
    final myService = Get.find<MyService>();
    final prefs = myService.sharedPreferences;
    final token = prefs.getString(SharedPreferencesKey.tokenKey);

    final response = await http.get(
      Uri.parse(AppLink.getAllStores),
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
      Get.snackbar("Failed", "Failed to load stores: ${response.statusCode}");
      throw Exception("Failed to load stores: ${response.statusCode}");
    }
  }

  Future<Store?> fetchStoreById(String id) async {
    final myService = Get.find<MyService>();
    final prefs = myService.sharedPreferences;
    final token = prefs.getString(SharedPreferencesKey.tokenKey);

    final url = '${AppLink.getAllStores}/$id';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['data'] != null) {
        final store = Store.fromJson(data["data"]);

        return store;
      } else {
        return null;
      }
    } else {
      throw Exception("Failed to load store: ${response.statusCode}");
    }
  }

  // Future<void> addReview(String storeId, Review newReview) async {
  //   await Future.delayed(const Duration(seconds: 1));
  //   final store = storeCardItems.firstWhere((p) => p.id == storeId);
  //   store.reviews.add(newReview);
  // }
}
