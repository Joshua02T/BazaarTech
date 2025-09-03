import 'dart:convert';

import 'package:bazaartech/core/service/link.dart';
import 'package:bazaartech/core/service/my_service.dart';
import 'package:bazaartech/core/service/shared_preferences_key.dart';
import 'package:bazaartech/view/cart/controller/cartcontroller.dart';
import 'package:bazaartech/view/cart/controller/locationpicker.dart';
import 'package:bazaartech/view/cart/models/addressmodel.dart';
import 'package:bazaartech/view/cart/widgets/addaddressdialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CheckoutController extends GetxController {
  CartController cartController = Get.find<CartController>();
  final myService = Get.find<MyService>();
  final RxList<AddressModel> addressList = <AddressModel>[].obs;
  double deliveryfee = 40;
  double taxes = 4;
  String addressToDeliver = '';
  String paymentMethod = 'Syriatel Cash';

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

  Future<void> deleteAddress(String id) async {
    try {
      final prefs = myService.sharedPreferences;
      final token = prefs.getString(SharedPreferencesKey.tokenKey);
      final url = "${AppLink.createAddress}/$id";

      final response = await http.delete(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        addressList.removeWhere((addr) => addr.id == id);
        update();
        Get.back();
        Get.snackbar("Success", "Address deleted successfully");
      } else {
        Get.snackbar(
            "Error", "Failed to delete address (${response.statusCode})");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> addNewAddress(AddressModel newAddress) async {
    try {
      final prefs = myService.sharedPreferences;
      final token = prefs.getString(SharedPreferencesKey.tokenKey);

      final response = await http.post(
        Uri.parse(AppLink.createAddress),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        body: {
          "label": newAddress.place,
          "city": newAddress.address,
          "latitude": newAddress.latitude.toString(),
          "longitude": newAddress.longitude.toString(),
          "phone_number": newAddress.number,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        if (data["success"] == true) {
          final AddressModel createdAddress =
              AddressModel.fromJson(data["data"]);

          if (addressList.isEmpty) {
            createdAddress.isSelected = true;
            addressToDeliver = createdAddress.id;
          }

          addressList.add(createdAddress);
          update();
        } else {
          Get.snackbar("Error", data["message"] ?? "Failed to create address");
        }
      } else {
        Get.snackbar("Error", "Something went wrong (${response.statusCode})");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> updateAddress(AddressModel address) async {
    try {
      final prefs = myService.sharedPreferences;
      final token = prefs.getString(SharedPreferencesKey.tokenKey);

      final response = await http.put(
        Uri.parse('${AppLink.createAddress}/${address.id}'),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
        body: {
          "label": address.place,
          "city": address.address,
          "latitude": address.latitude.toString(),
          "longitude": address.longitude.toString(),
          "phone_number": address.number,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        if (data["success"] == true) {
          final AddressModel updatedAddress =
              AddressModel.fromJson(data["data"]);

          int index = addressList.indexWhere((a) => a.id == updatedAddress.id);
          if (index != -1) {
            addressList[index] = updatedAddress;
          }

          update();
        } else {
          Get.snackbar("Error", data["message"] ?? "Failed to update address");
        }
      } else {
        Get.snackbar("Error", "Something went wrong (${response.statusCode})");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void showAddAddressDialog(BuildContext context) {
    final locationController = Get.find<LocationPickerController>();
    final GlobalKey<FormState> addingAddressKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (_) => AddAddressDialog(
        formKey: addingAddressKey,
        initialAddress: locationController.selectedAddressName.value,
        isFirstAddress: addressList.isEmpty,
        onAdd: (newAddress) {
          addNewAddress(newAddress);
        },
      ),
    );
  }

  Future<void> fetchAddresses() async {
    try {
      final prefs = myService.sharedPreferences;
      final token = prefs.getString(SharedPreferencesKey.tokenKey);
      final response = await http.get(
        Uri.parse(AppLink.getAddress),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success'] == true) {
          final List list = data['data'];
          addressList
              .assignAll(list.map((e) => AddressModel.fromJson(e)).toList());
          update();
        } else {
          Get.snackbar("Error", data['message'] ?? "Something went wrong");
        }
      } else {
        Get.snackbar("Error", "Failed to load addresses");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  double getTotalPrice() {
    double total = cartController.getSubTotalPrice() + deliveryfee;
    total += (total * taxes) / 100;
    return total;
  }

  @override
  void onInit() {
    fetchAddresses();
    super.onInit();
  }
}
