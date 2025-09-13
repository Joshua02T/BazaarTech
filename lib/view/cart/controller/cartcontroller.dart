import 'package:bazaartech/core/repositories/cartrepo.dart';
import 'package:bazaartech/view/cart/models/cartitemmodel.dart';
import 'package:bazaartech/widget/customtoast.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final List<CartItem> cartItems = <CartItem>[];
  final List<String> uniqueMarkerNames = <String>[];
  final CartRepo cartRepo = CartRepo();
  bool isLoading = false;

  Future<void> getCartItems() async {
    try {
      isLoading = true;
      update();
      final cartItemsFetched = await cartRepo.fetchCartItems();
      cartItems.assignAll(cartItemsFetched);
      _updateUniqueMarkers();
    } catch (e) {
      ToastUtil.showToast('Failed to load cart items, ${e.toString()}');
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> increaseQuantity(CartItem item) async {
    try {
      final CartItem updatedCartItem = await cartRepo.addToCart(item.product.id,
          isFromBazaar: item.bazaarId?.toString());
      int index =
          cartItems.indexWhere((c) => c.id.toString() == item.id.toString());
      if (index != -1) {
        cartItems[index] = updatedCartItem;
        ToastUtil.showToast('Quantity increased');
      }
      update();
    } catch (e) {
      ToastUtil.showToast(e.toString());
    }
  }

  Future<void> decreaseQuantity(CartItem item) async {
    try {
      if (item.quantity > 1) {
        final CartItem updatedCartItem =
            await cartRepo.decreaseCartQuantity(item.product.id.toString());
        int index =
            cartItems.indexWhere((c) => c.id.toString() == item.id.toString());
        if (index != -1) {
          cartItems[index] = updatedCartItem;
          ToastUtil.showToast('Removed quantity');
        }
        update();
      }
    } catch (e) {
      ToastUtil.showToast(e.toString());
    }
  }

  void _updateUniqueMarkers() {
    uniqueMarkerNames.assignAll(
        cartItems.map((item) => item.product.markerName).toSet().toList());
    update();
  }

  List<CartItem> getProductsByMarker(String markerName) {
    return cartItems.where((e) => e.product.markerName == markerName).toList();
  }

  Future<void> removeFromCart(String id) async {
    try {
      final success = await cartRepo.deleteCartItem(id);

      if (success) {
        cartItems.removeWhere((c) => c.product.id.toString() == id);
        _updateUniqueMarkers();
        ToastUtil.showToast("Cart deleted successfully");
        update();
      }
    } catch (e) {
      ToastUtil.showToast("Failed to delete cart: $e");
    }
  }

  double getSubTotalPrice() {
    double subtotal = 0;
    for (CartItem item in cartItems) {
      subtotal += item.product.price * item.quantity;
    }
    return subtotal;
  }

  @override
  void onInit() {
    getCartItems();
    super.onInit();
  }
}
