import 'dart:convert';

import 'package:bazaartech/core/service/link.dart';
import 'package:bazaartech/core/service/my_service.dart';
import 'package:bazaartech/core/service/shared_preferences_key.dart';
import 'package:bazaartech/helper/appconfig.dart';
import 'package:bazaartech/model/commentmodel.dart';
import 'package:bazaartech/view/home/model/storemodel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class StoreRepository {
  Future<List<Store>> fetchStores(String name) async {
    final myService = Get.find<MyService>();
    final prefs = myService.sharedPreferences;
    final token = prefs.getString(SharedPreferencesKey.tokenKey);

    final uri = Uri.parse(AppLink.getAllStores).replace(
      queryParameters: {
        'name': name,
      },
    );

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
        if (store.image.contains("127.0.0.1")) {
          store.image = store.image
              .replaceAll("http://127.0.0.1:8000", AppConfig.getBaseUrl());
        }

        return store;
      } else {
        return null;
      }
    } else {
      throw Exception("Failed to load store: ${response.statusCode}");
    }
  }

  Future<List<Comment>> fetchCommentsById(String id) async {
    final myService = Get.find<MyService>();
    final prefs = myService.sharedPreferences;
    final token = prefs.getString(SharedPreferencesKey.tokenKey);

    final response = await http.get(
      Uri.parse('${AppLink.getAllStores}/$id/comments'),
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
