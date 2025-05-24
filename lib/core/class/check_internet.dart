import 'dart:io';

checkInternet() async {
  try {
    var result = await InternetAddress.lookup("myUrl");
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    return false;
  }
}
