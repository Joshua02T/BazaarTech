import 'package:bazaartech/view/cart/models/addressmodel.dart';
import 'package:bazaartech/view/cart/models/cartitemmodel.dart';
import 'package:bazaartech/view/cart/widgets/addaddressdialog.dart';
import 'package:bazaartech/widget/customtoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bazaartech/view/home/model/productmodel.dart';

class CartController extends GetxController {
  final RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final RxList<String> uniqueMarkerNames = <String>[].obs;
  final RxList<AddressModel> addressList = <AddressModel>[].obs;

  double deliveryfee = 40;
  double taxes = 4;
  String addressToDeliver = '';
  String paymentMethod = 'Syriatel Cash';
  void addNewAddress(AddressModel newAddress) {
    if (addressList.isEmpty) {
      newAddress.isSelected = true;
      addressToDeliver = newAddress.id;
    }
    addressList.add(newAddress);
    update();
  }

  void selectAddress(String addressId) {
    for (var addr in addressList) {
      addr.isSelected = addr.id == addressId;
    }
    addressToDeliver = addressId;
    update();
  }

  void changePaymentMethod(String newPaymentMethod) {
    paymentMethod = newPaymentMethod;
    update();
  }

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

  double getTotalPrice() {
    double total = getSubTotalPrice() + deliveryfee;
    total += (total * taxes) / 100;
    return total;
  }

  void showAddAddressDialog(BuildContext context) {
    final TextEditingController locationController = TextEditingController();
    final TextEditingController numberController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final GlobalKey<FormState> addingAddressKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (_) => AddAddressDialog(
        formKey: addingAddressKey,
        initialPlace: locationController.text,
        initialNumber: numberController.text,
        initialAddress: addressController.text,
        isFirstAddress: addressList.isEmpty,
        onAdd: (newAddress) {
          addNewAddress(newAddress);
        },
      ),
    );
  }

  void updateAddress(AddressModel updatedAddress) {
    int index = addressList.indexWhere((a) => a.id == updatedAddress.id);
    if (index != -1) {
      addressList[index] = updatedAddress;
      update();
    }
  }
}
