import 'package:bazaartech/core/service/link.dart';
import 'package:bazaartech/core/service/my_service.dart';
import 'package:bazaartech/core/service/shared_preferences_key.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FavoriteRepository {
  Future<bool> addToFavorite(String kind, String id) async {
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
      return true;
    } else {
      throw Exception("Something went wrong (${response.statusCode})");
    }
  }
}
