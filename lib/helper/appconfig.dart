import 'dart:io';

import 'package:flutter/foundation.dart';

class AppConfig {
  static String getBaseUrl() {
    if (Platform.isAndroid && !kIsWeb) {
      return 'http://192.168.1.102:8000';
    }

    return 'http://127.0.0.1:8000';
  }
}
