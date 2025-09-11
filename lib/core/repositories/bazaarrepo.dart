import 'dart:convert';

import 'package:bazaartech/core/service/link.dart';
import 'package:bazaartech/core/service/my_service.dart';
import 'package:bazaartech/core/service/shared_preferences_key.dart';
import 'package:bazaartech/helper/appconfig.dart';
import 'package:bazaartech/view/home/model/bazaarmodel.dart';
import 'package:bazaartech/model/commentmodel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BazaarRepository {
  Future<List<Bazaar>> fetchBazaars(String name) async {
    final myService = Get.find<MyService>();
    final prefs = myService.sharedPreferences;
    final token = prefs.getString(SharedPreferencesKey.tokenKey);

    final uri = Uri.parse(AppLink.getAllBazaars).replace(
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
      Get.snackbar("Failed", "Failed to load bazaars: ${response.statusCode}");
      throw Exception("Failed to load bazaars: ${response.statusCode}");
    }
  }

  Future<Bazaar?> fetchBazaarById(String id) async {
    final myService = Get.find<MyService>();
    final prefs = myService.sharedPreferences;
    final token = prefs.getString(SharedPreferencesKey.tokenKey);

    final url = '${AppLink.getAllBazaars}/$id';

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
        final bazaar = Bazaar.fromJson(data["data"]);
        if (bazaar.image.contains("127.0.0.1")) {
          bazaar.image = bazaar.image
              .replaceAll("http://127.0.0.1:8000", AppConfig.getBaseUrl());
        }

        return bazaar;
      } else {
        return null;
      }
    } else {
      throw Exception("Failed to load bazaar: ${response.statusCode}");
    }
  }

  Future<List<Comment>> fetchCommentsById(String id) async {
    final myService = Get.find<MyService>();
    final prefs = myService.sharedPreferences;
    final token = prefs.getString(SharedPreferencesKey.tokenKey);

    final response = await http.get(
      Uri.parse('${AppLink.getAllBazaars}/$id/comments'),
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
