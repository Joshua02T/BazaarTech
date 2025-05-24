import 'package:bazaartech/core/service/shared_preferences_key.dart';
import 'package:get/get.dart';
import 'package:bazaartech/core/service/my_service.dart';
import 'package:bazaartech/core/service/routes.dart';

class SplashController extends GetxController {
  final myService = Get.find<MyService>();

  @override
  void onInit() {
    super.onInit();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 3));

    final isLoggedIn =
        myService.sharedPreferences.getBool(SharedPreferencesKey.isLogInKey) ??
            false;

    if (isLoggedIn) {
      Get.offAllNamed(Routes.mainPage);
    } else {
      Get.offAllNamed(Routes.login);
    }
  }
}
