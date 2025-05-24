import 'package:bazaartech/core/const_data/lists.dart';
import 'package:bazaartech/view/home/model/storemodel.dart';

class StoreRepository {
  Future<List<Store>> fetchStores() async {
    return storeCardItems;
  }

  Future<Store?> fetchStoreById(String id) async {
    await Future.delayed(const Duration(seconds: 2));
    return storeCardItems.firstWhere((store) => store.id == id);
  }

  Future<void> addReview(String storeId, Review newReview) async {
    await Future.delayed(const Duration(seconds: 1));
    final store = storeCardItems.firstWhere((p) => p.id == storeId);
    store.reviews.add(newReview);
  }
}
