import 'package:bazaartech/core/repositories/productrepo.dart';
import 'package:bazaartech/view/home/model/commentmodel.dart';
import 'package:bazaartech/widget/customtoast.dart';
import 'package:get/get.dart';
import 'package:bazaartech/view/home/model/productmodel.dart';

class ProductDetailsController extends GetxController {
  final ProductRepository _productRepo = ProductRepository();
  Product? product;
  bool isLoadingFetching = false;
  final comments = <Comment>[];

  int rating = 0;
  final String id;

  ProductDetailsController(this.id);

  void setRating(int value) {
    rating = value;
    update();
  }

  Future<void> fetchProduct(String id) async {
    try {
      isLoadingFetching = true;
      update();
      final fetchedProduct = await _productRepo.fetchProductById(id);
      product = fetchedProduct;
      comments.assignAll(fetchedProduct!.comments);
    } catch (e) {
      ToastUtil.showToast('Failed to load product, ${e.toString()}');
    } finally {
      isLoadingFetching = false;
      update();
    }
  }

  @override
  void onInit() {
    fetchProduct(id);
    super.onInit();
  }
}
