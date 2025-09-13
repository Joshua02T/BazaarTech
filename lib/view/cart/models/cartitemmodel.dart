import 'package:bazaartech/view/home/model/productmodel.dart';

class CartItem {
  final int id;
  final int quantity;
  final int? bazaarId;
  final Product product;

  CartItem({
    required this.id,
    required this.quantity,
    this.bazaarId,
    required this.product,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] ?? 0,
      quantity: json['quantity'] ?? 0,
      bazaarId: json['bazaar_id'],
      product: Product.fromJson(json['product'] ?? {}),
    );
  }
}
