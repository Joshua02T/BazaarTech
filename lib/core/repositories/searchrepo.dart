import 'dart:convert';

import 'package:bazaartech/core/service/link.dart';
import 'package:bazaartech/core/service/my_service.dart';
import 'package:bazaartech/core/service/shared_preferences_key.dart';
import 'package:bazaartech/model/categorymodel.dart';
import 'package:bazaartech/widget/customtoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SearchRepo {
  Future<List<Category>> fetchSearchCategories(String item, String body) async {
    final myService = Get.find<MyService>();
    final prefs = myService.sharedPreferences;
    final token = prefs.getString(SharedPreferencesKey.tokenKey);

    final response = await http.get(
      Uri.parse('${AppLink.appRoot}/$item-categories?name=$body'),
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
          final category = Category.fromJson(json);
          return category;
        }).toList();
      } else {
        return [];
      }
    } else {
      ToastUtil.showToast("Failed to load categories: ${response.statusCode}");
      throw Exception("Failed to load categories: ${response.statusCode}");
    }
  }
}
