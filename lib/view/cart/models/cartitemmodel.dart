import 'package:bazaartech/view/home/model/productmodel.dart';

class CartItemModel {
  final Product product;
  int quantity;

  CartItemModel({required this.product, this.quantity = 1});
}
