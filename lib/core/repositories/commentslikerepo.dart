import 'package:bazaartech/core/service/link.dart';
import 'package:bazaartech/core/service/my_service.dart';
import 'package:bazaartech/core/service/shared_preferences_key.dart';
import 'package:bazaartech/view/productdetails/controller/commentscontroller.dart';
import 'package:bazaartech/widget/customtoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CommentsLikeRepo {
  CommentsController controller = Get.find<CommentsController>();
  Future addLike(String id) async {
    try {
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
        controller.update();
        ToastUtil.showToast('you liked the comment!');
      } else {
        Get.snackbar('Error', response.statusCode.toString());
        throw Exception("Something went wrong (${response.statusCode})");
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      throw Exception("Error: $e");
    }
  }

  Future deleteLike(String id) async {
    try {
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
        controller.update();
        ToastUtil.showToast('you removed the like on the comment!');
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
