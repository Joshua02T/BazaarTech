import 'package:bazaartech/core/service/my_service.dart';
import 'package:bazaartech/core/service/routes.dart';
import 'package:bazaartech/core/service/shared_preferences_key.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final TextEditingController nameContoller = TextEditingController();
  final TextEditingController emailContoller = TextEditingController();
  final TextEditingController phoneContoller = TextEditingController();
  final TextEditingController passwordContoller = TextEditingController();
  final TextEditingController confirmPasswordContoller =
      TextEditingController();
  String? password;
  RxBool passwordVisible = false.obs;
  RxBool passwordVisible2 = false.obs;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final myService = Get.find<MyService>();
  Future<void> signUp() async {
    globalKey.currentState!.save();
    if (globalKey.currentState!.validate()) {
      await myService.sharedPreferences
          .setBool(SharedPreferencesKey.isLogInKey, true);

      await myService.sharedPreferences
          .setString(SharedPreferencesKey.userNameKey, nameContoller.text);
      await myService.sharedPreferences
          .setString(SharedPreferencesKey.userEmailKey, emailContoller.text);
      await myService.sharedPreferences
          .setString(SharedPreferencesKey.userNumberKey, phoneContoller.text);

      Get.offAllNamed(Routes.mainPage);
    }
  }
}
