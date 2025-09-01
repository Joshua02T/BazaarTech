class AppLink {
  static String appRoot = "http://192.168.1.102:8000/api";

  static String register = "$appRoot/register";

  static String signin = "$appRoot/login";

  static String logout = "$appRoot/logout";

  static String profile = "$appRoot/me";

  Map<String, String> getHeader() {
    Map<String, String> mainHeader = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
    };
    return mainHeader;
  }
}
