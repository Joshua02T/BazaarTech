import 'package:bazaartech/core/service/my_service.dart';
import 'package:bazaartech/core/service/routes.dart';
import 'package:bazaartech/core/service/shared_preferences_key.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final TextEditingController emailContoller = TextEditingController();
  final TextEditingController passwordContoller = TextEditingController();
  RxBool passwordVisible = false.obs;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final myService = Get.find<MyService>();

  Future<void> login() async {
    if (globalKey.currentState!.validate()) {
      await myService.sharedPreferences
          .setBool(SharedPreferencesKey.isLogInKey, true);

      Get.offAllNamed(Routes.mainPage);
    }
  }
}
