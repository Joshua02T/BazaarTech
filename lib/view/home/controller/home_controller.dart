import 'package:bazaartech/core/repositories/bazaarrepo.dart';
import 'package:bazaartech/core/repositories/cartrepo.dart';
import 'package:bazaartech/core/repositories/favoriterepo.dart';
import 'package:bazaartech/core/repositories/productrepo.dart';
import 'package:bazaartech/core/repositories/storerepo.dart';
import 'package:bazaartech/view/cart/models/cartitemmodel.dart';
import 'package:bazaartech/view/home/model/bazaarmodel.dart';
import 'package:bazaartech/view/home/model/productmodel.dart';
import 'package:bazaartech/view/home/model/storemodel.dart';
import 'package:bazaartech/widget/customtoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  final ProductRepository productRepo = ProductRepository();
  final StoreRepository storeRepo = StoreRepository();
  final BazaarRepository bazaarRepo = BazaarRepository();
  final FavoriteRepository favoriteRepo = FavoriteRepository();
  final CartRepo cartRepo = CartRepo();

  final List<Product> productCardItem = <Product>[];
  final List<Store> storeCardItem = <Store>[];
  final List<Bazaar> bazaarCardItem = <Bazaar>[];

  bool isLoading = false;
  bool isLoadingAddingToCart = false;
  Map<String, bool> isLoadingAddingToFavorite = {};

  int selectedIndex = 0;
  final PageController pageController = PageController();

  final List<dynamic> allItems = <dynamic>[];

  Future<CartItem> addToCart(int productId, {String? isFromBazaar}) async {
    try {
      isLoadingAddingToCart = true;
      update();

      CartItem addedCartItem =
          await cartRepo.addToCart(productId, isFromBazaar: isFromBazaar);

      ToastUtil.showToast('Item added to cart');
      return addedCartItem;
    } catch (e) {
      Get.snackbar("Error", e.toString());
      throw Exception("Failed to add to cart: $e");
    } finally {
      isLoadingAddingToCart = false;
      update();
    }
  }

  Future<void> loadInitialData() async {
    try {
      isLoading = true;
      update();

      final products = await productRepo.fetchProducts('', '', '', '', [], []);
      productCardItem.assignAll(products);

      final stores = await storeRepo.fetchStores('', '', [], []);
      storeCardItem.assignAll(stores);

      final bazaars = await bazaarRepo.fetchBazaars('', '', '', '', [], []);
      bazaarCardItem.assignAll(bazaars);

      final tempItems = [
        ...productCardItem
            .map((product) => {'type': 'product', 'data': product}),
        ...storeCardItem.map((store) => {'type': 'store', 'data': store}),
      ];
      allItems.assignAll(tempItems);
      allItems.shuffle();
    } catch (e) {
      print(e.toString());
      ToastUtil.showToast('Failed to load data, ${e.toString()}');
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<bool> addOrRemoveFavorite(String kind, String id) async {
    isLoadingAddingToFavorite[id] = true;
    update();

    try {
      final bool newState = await favoriteRepo.toggleFavorite(kind, id);

      if (kind == 'product') {
        final index = productCardItem.indexWhere((c) => c.id.toString() == id);
        if (index != -1) productCardItem[index].isFavorite = newState;
      } else if (kind == 'store') {
        final index = storeCardItem.indexWhere((c) => c.id.toString() == id);
        if (index != -1) storeCardItem[index].isFavorite = newState;
      } else {
        final index = bazaarCardItem.indexWhere((c) => c.id.toString() == id);
        if (index != -1) bazaarCardItem[index].isFavorite = newState;
      }

      ToastUtil.showToast(
        newState ? 'Added to Favorite!' : 'Removed from Favorite!',
      );

      return true;
    } catch (e) {
      ToastUtil.showToast('Failed to update favorite');
      return false;
    } finally {
      isLoadingAddingToFavorite[id] = false;
      update();
    }
  }

  bool getIsFavorite(String kind, String id) {
    if (kind == 'product') {
      final i = productCardItem.indexWhere((c) => c.id.toString() == id);
      return productCardItem[i].isFavorite;
    } else if (kind == 'store') {
      final i = storeCardItem.indexWhere((c) => c.id.toString() == id);
      return storeCardItem[i].isFavorite;
    } else {
      final i = bazaarCardItem.indexWhere((c) => c.id.toString() == id);
      return bazaarCardItem[i].isFavorite;
    }
  }

  Future<void> refreshData() async {
    try {
      await loadInitialData();
      updateSelectedIndex(0);
    } catch (e) {
      ToastUtil.showToast("Couldn't refresh data");
    }
  }

  void updateSelectedIndex(int index) {
    selectedIndex = index;
    update();
  }

  @override
  void onInit() {
    loadInitialData();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
