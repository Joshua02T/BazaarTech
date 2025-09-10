import 'dart:convert';

import 'package:bazaartech/core/service/link.dart';
import 'package:bazaartech/core/service/my_service.dart';
import 'package:bazaartech/core/service/shared_preferences_key.dart';
import 'package:bazaartech/helper/appconfig.dart';
import 'package:bazaartech/view/bazaardetails/controller/bazaardetailscontroller.dart';
import 'package:bazaartech/view/home/model/productmodel.dart';
import 'package:bazaartech/widget/customtoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BazaarProdcutsController extends GetxController {
  final String categoryId;

  BazaarProdcutsController(this.categoryId);

  bool isLoading = false;
  List<Product> products = [];

  Future<void> loadProductsBasedOnCategoryId(String cateid) async {
    try {
      isLoading = true;
      update();

      final myService = Get.find<MyService>();
      final prefs = myService.sharedPreferences;
      final token = prefs.getString(SharedPreferencesKey.tokenKey);

      final response = await http.get(
        Uri.parse(
            '${AppLink.getAllBazaars}/${Get.find<BazaarDetailsController>().id}/products?category_id=$cateid'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['data'] != null) {
          final fetchedProducts = (data['data'] as List).map((json) {
            final product = Product.fromJson(json);

            if (product.image.contains("127.0.0.1")) {
              product.image = product.image
                  .replaceAll("http://127.0.0.1:8000", AppConfig.getBaseUrl());
            }

            return product;
          }).toList();

          products = fetchedProducts;
        } else {
          products = [];
        }
      } else {
        Get.snackbar(
          "Failed",
          "Failed to load products: ${response.statusCode}",
        );
        throw Exception("Failed to load products: ${response.statusCode}");
      }
    } catch (e) {
      ToastUtil.showToast('Failed to load products, ${e.toString()}');
      products = [];
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onInit() {
    loadProductsBasedOnCategoryId(categoryId);
    super.onInit();
  }
}
