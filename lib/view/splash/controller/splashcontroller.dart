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
    final bool isLoggedIn =
        myService.sharedPreferences.getBool(SharedPreferencesKey.isLogInKey) ??
            false;
    final String hasValidToken =
        myService.sharedPreferences.getString(SharedPreferencesKey.tokenKey) ??
            '';

    isLoggedIn && hasValidToken.isNotEmpty
        ? Get.offAllNamed(Routes.mainPage)
        : Get.offAllNamed(Routes.login);
  }
}
