class AppLink {
  static String appRoot = "http://192.168.1.103:8000/api";

  static String register = "$appRoot/register";

  static String addToCart = "$appRoot/add";

  static String getCartItmes = "$appRoot/";

  static String fetchFavorite = "$appRoot/favorite";

  static String fetchOrders = "$appRoot/orders";

  static String decreseCartItemQuantity = "$appRoot/remove";

  static String completePayment = "$appRoot/checkout";

  static String signin = "$appRoot/login";

  static String getAllProducts = "$appRoot/products";

  static String getAllStores = "$appRoot/stores";

  static String getAllBazaars = "$appRoot/bazaars";

  static String comments = "$appRoot/comments";

  static String logout = "$appRoot/logout";

  static String profile = "$appRoot/me";

  static String getAddress = "$appRoot/addresses";

  static String createAddress = "$appRoot/address";

  static String deleteProfileImage = "$appRoot/profileImage";

  Map<String, String> getHeader() {
    Map<String, String> mainHeader = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
    };
    return mainHeader;
  }
}
