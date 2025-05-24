import 'package:bazaartech/core/repositories/bazaarrepo.dart';
import 'package:bazaartech/core/repositories/favoriterepo.dart';
import 'package:bazaartech/core/repositories/productrepo.dart';
import 'package:bazaartech/core/repositories/storerepo.dart';
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

  final RxList<Store> storeCardItem = <Store>[].obs;
  final RxList<Product> productCardItem = <Product>[].obs;
  final RxList<Bazaar> bazaarCardItem = <Bazaar>[].obs;

  bool isLoading = false;

  final FavoriteRepository favoriteRepo = FavoriteRepository();
  final RxList<Map<String, dynamic>> favoriteItems =
      <Map<String, dynamic>>[].obs;

  int selectedIndex = 0;
  final PageController pageController = PageController();

  late final List<String> storeItemIds;
  late final List<String> productItemIds;
  late final List<String> bazaarItemIds;

  final RxMap<String, RxBool> _heartStates = <String, RxBool>{}.obs;
  final List<dynamic> allItems = <dynamic>[];
  final Map<String, bool> _heartLoadingStates = {};

  Future<void> loadInitialData() async {
    try {
      isLoading = true;
      update();
      await Future.delayed(const Duration(seconds: 3));

      final products = await productRepo.fetchProducts();
      productCardItem.assignAll(products);

      final stores = await storeRepo.fetchStores();
      storeCardItem.assignAll(stores);

      final bazaars = await bazaarRepo.fetchBazaars();
      bazaarCardItem.assignAll(bazaars);

      storeItemIds = storeCardItem.map((store) => store.id).toList();
      productItemIds = productCardItem.map((product) => product.id).toList();
      bazaarItemIds = bazaarCardItem.map((bazaar) => bazaar.id).toList();

      initializeHearts(storeItemIds, productItemIds, bazaarItemIds);

      final tempItems = [
        ...storeCardItem.map((store) => {'type': 'store', 'data': store}),
        ...productCardItem
            .map((product) => {'type': 'product', 'data': product}),
      ];
      tempItems.shuffle();
      allItems.assignAll(tempItems);
    } catch (e) {
      ToastUtil.showToast('Failed to load data, ${e.toString()}');
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> refreshData() async {
    try {
      isLoading = true;
      update();
      await Future.delayed(const Duration(seconds: 2));

      final products = await productRepo.fetchProducts();
      productCardItem.assignAll(products);

      final stores = await storeRepo.fetchStores();
      storeCardItem.assignAll(stores);

      final bazaars = await bazaarRepo.fetchBazaars();
      bazaarCardItem.assignAll(bazaars);
      final tempItems = [
        ...storeCardItem.map((store) => {'type': 'store', 'data': store}),
        ...productCardItem
            .map((product) => {'type': 'product', 'data': product}),
      ];
      tempItems.shuffle();
      allItems.assignAll(tempItems);
      updateSelectedIndex(0);
    } catch (e) {
      ToastUtil.showToast("Couldn't refresh feed");
    } finally {
      isLoading = false;
      update();
    }
  }

  void updateSelectedIndex(int index) {
    selectedIndex = index;
    update();
  }

  bool isHeartFilled(String id) {
    return _heartStates[id]?.value ?? false;
  }

  Future<void> toggleHeart(String id) async {
    try {
      _heartLoadingStates[id] = true;
      update();

      if (_heartStates.containsKey(id)) {
        final isFavorite = !_heartStates[id]!.value;
        _heartStates[id]!.value = isFavorite;

        if (isFavorite) {
          final store = storeCardItem.firstWhereOrNull((e) => e.id == id);
          final product = productCardItem.firstWhereOrNull((e) => e.id == id);
          final bazaar = bazaarCardItem.firstWhereOrNull((e) => e.id == id);

          Map<String, dynamic>? itemToAdd;
          if (store != null) {
            itemToAdd = {'type': 'store', 'data': store};
          } else if (product != null) {
            itemToAdd = {'type': 'product', 'data': product};
          } else if (bazaar != null) {
            itemToAdd = {'type': 'bazaar', 'data': bazaar};
          }

          if (itemToAdd != null) {
            final success =
                await favoriteRepo.addFavorite(itemToAdd, favoriteItems);
            if (success) {
              favoriteItems.add(itemToAdd);
              ToastUtil.showToast('Added to favorites');
            } else {
              _heartStates[id]!.value = false;
            }
          }
        } else {
          final success = await favoriteRepo.removeFavorite(id, favoriteItems);
          if (success) {
            favoriteItems
                .removeWhere((item) => (item['data'] as dynamic).id == id);
            ToastUtil.showToast('Removed from favorites');
          } else {
            _heartStates[id]!.value = true;
          }
        }
      }
    } catch (e) {
      ToastUtil.showToast('Failed to update favorite');
      if (_heartStates.containsKey(id)) {
        _heartStates[id]!.value = !_heartStates[id]!.value;
      }
    } finally {
      _heartLoadingStates.remove(id);
      update();
    }
  }

  bool isHeartLoading(String id) {
    return _heartLoadingStates[id] ?? false;
  }

  void initializeHearts(
    List<String> storeIds,
    List<String> productIds,
    List<String> bazaarIds,
  ) {
    final allIds = [...storeIds, ...productIds, ...bazaarIds];
    for (final id in allIds) {
      _heartStates[id] = false.obs;
    }
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
