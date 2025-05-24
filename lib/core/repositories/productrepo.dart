import 'package:bazaartech/core/const_data/lists.dart';
import 'package:bazaartech/view/home/model/productmodel.dart';

class ProductRepository {
  Future<List<Product>> fetchProducts() async {
    return productCardItems;
  }

  Future<Product?> fetchProductById(String id) async {
    await Future.delayed(const Duration(seconds: 2));
    return productCardItems.firstWhere((product) => product.id == id);
  }

  Future<void> addComment(String productId, Comment newComment) async {
    await Future.delayed(const Duration(seconds: 1));
    final product = productCardItems.firstWhere((p) => p.id == productId);
    product.comments.add(newComment);
  }
}
