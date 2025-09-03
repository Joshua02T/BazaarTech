import 'package:bazaartech/view/cart/models/cartitemmodel.dart';
import 'package:bazaartech/widget/customtoast.dart';
import 'package:get/get.dart';
import 'package:bazaartech/view/home/model/productmodel.dart';

class CartController extends GetxController {
  final RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final RxList<String> uniqueMarkerNames = <String>[].obs;

  void addToCart(Product product) {
    var existingItem =
        cartItems.firstWhereOrNull((item) => item.product.id == product.id);
    if (existingItem != null) {
      existingItem.quantity++;
    } else {
      cartItems.add(CartItemModel(product: product));
      _updateUniqueMarkers();
    }
    cartItems.refresh();
    ToastUtil.showToast('Item added to cart!');
  }

  void removeFromCart(CartItemModel item) {
    cartItems.remove(item);
    _updateUniqueMarkers();
    update();
    ToastUtil.showToast('Item removed from cart!');
  }

  void increaseQuantity(CartItemModel item) {
    item.quantity++;
    update();
    cartItems.refresh();
  }

  void decreaseQuantity(CartItemModel item) {
    if (item.quantity > 1) {
      item.quantity--;
      update();
      cartItems.refresh();
    }
  }

  void _updateUniqueMarkers() {
    uniqueMarkerNames.assignAll(
        cartItems.map((item) => item.product.markerName).toSet().toList());
  }

  List<CartItemModel> getProductsByMarker(String markerName) {
    return cartItems.where((e) => e.product.markerName == markerName).toList();
  }

  double getSubTotalPrice() {
    double subtotal = 0;
    for (CartItemModel item in cartItems) {
      subtotal += item.product.price * item.quantity;
    }
    return subtotal;
  }
}
