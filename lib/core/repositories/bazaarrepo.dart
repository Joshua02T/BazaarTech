import 'package:bazaartech/core/const_data/lists.dart';
import 'package:bazaartech/view/home/model/bazaarmodel.dart';
import 'package:bazaartech/model/commentmodel.dart';

class BazaarRepository {
  Future<List<Bazaar>> fetchBazaars() async {
    return bazaarCardItems;
  }

  Future<Bazaar?> fetchBazaarById(String id) async {
    await Future.delayed(const Duration(seconds: 2));
    return bazaarCardItems.firstWhere((bazaar) => bazaar.id == id);
  }

  Future<void> addReview(String bazaarId, Comment newReview) async {
    await Future.delayed(const Duration(seconds: 1));
    final bazaar = bazaarCardItems.firstWhere((p) => p.id == bazaarId);
    bazaar.reviews.add(newReview);
  }
}
