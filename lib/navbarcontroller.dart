import 'package:bazaartech/view/favorite/controller/favcontroller.dart';
import 'package:bazaartech/view/notifications/controller/noticontroller.dart';
import 'package:bazaartech/view/search/controller/searchcontroller.dart';
import 'package:get/get.dart';

class NavBarController extends GetxController {
  RxInt selectedIndex = 0.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

  void deleteController(int index) {
    switch (index) {
      case 1:
        if (Get.isRegistered<SearchCController>()) {
          Get.delete<SearchCController>();
        }
        break;
      case 2:
        if (Get.isRegistered<FavoriteController>()) {
          Get.delete<FavoriteController>();
        }
        break;
      case 3:
        if (Get.isRegistered<NotificationsController>()) {
          Get.delete<NotificationsController>();
        }
        break;
    }
  }
}
