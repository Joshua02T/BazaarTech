import 'package:bazaartech/view/favorite/controller/favcontroller.dart';
import 'package:bazaartech/view/notifications/controller/noticontroller.dart';
import 'package:bazaartech/view/search/controller/bazaarfiltercontroller.dart';
import 'package:bazaartech/view/search/controller/productfilercontroller.dart';
import 'package:bazaartech/view/search/controller/searchcontroller.dart';
import 'package:bazaartech/view/search/controller/storefiltercontroller.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoriteController>(() => FavoriteController(), fenix: true);
    Get.lazyPut<SearchCController>(() => SearchCController(), fenix: true);
    Get.lazyPut<BazaarFilterController>(() => BazaarFilterController(),
        fenix: true);
    Get.lazyPut<ProductFilterController>(() => ProductFilterController(),
        fenix: true);
    Get.lazyPut<StoreFilterController>(() => StoreFilterController(),
        fenix: true);
    Get.lazyPut<NotificationsController>(() => NotificationsController(),
        fenix: true);
    Get.lazyPut<FavoriteController>(() => FavoriteController(), fenix: true);
  }
}
