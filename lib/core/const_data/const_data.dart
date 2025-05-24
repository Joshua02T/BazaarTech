import 'dart:async';

class ConstData {
  static bool isLogIn = false;
  static String token = " ";
  static const String map_key = " ";

  static Future<void> UpdateToken() async {}

  static Future<void> startTokenupdater() async {
    Timer.periodic(Duration(seconds: 20), (timer) {
      UpdateToken();
    });
  }
}
