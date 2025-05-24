import '../const_data/const_data.dart';

class AppLink {
  //remote address
  static String appRoot = "https://";

  static String imageWithRoot = "$appRoot/storagr";

  static String imageWithoutRoot = "$appRoot";

  static String serverApiRoot = "$appRoot/api";

  static String home = "$serverApiRoot/home";

  static String user = "$serverApiRoot/user";
  static String profile = "$serverApiRoot/profile";
  static String notification = "$serverApiRoot/notification";

  Map<String, String> getHeader() {
    Map<String, String> mainHeader = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
    };
    return mainHeader;
  }

  Map<String, String> getHeaderToken() {
    Map<String, String> mainHeader = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'Authorization': 'Bearer${ConstData.token}'
    };
    return mainHeader;
  }
}
