import 'dart:convert';

import 'package:bazaartech/core/service/link.dart';
import 'package:bazaartech/core/service/my_service.dart';
import 'package:bazaartech/core/service/shared_preferences_key.dart';
import 'package:bazaartech/model/commentmodel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CommentsLikeRepo {
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
      return Comment.fromJson(data);
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
      return Comment.fromJson(data);
    } else {
      throw Exception("Something went wrong (${response.statusCode})");
    }
  }
}
