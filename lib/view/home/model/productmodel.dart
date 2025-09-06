// import 'package:bazaartech/model/commentmodel.dart';
// import 'package:get/get.dart';

// class Product {
//   final int id;
//   String image;
//   final String status;
//   final double price;
//   final double oldPrice;
//   final String name;
//   final String size;
//   final String markerName;
//   final int rating;
//   final String category;
//   final RxList<Comment> comments;
//   final String details;
//   int userRate;

//   Product({
//     required this.id,
//     required this.image,
//     required this.status,
//     required this.price,
//     required this.oldPrice,
//     required this.name,
//     required this.markerName,
//     required this.size,
//     required this.category,
//     required this.rating,
//     this.userRate = 0,
//     required List<Comment> comments,
//     required this.details,
//   }) : comments = RxList<Comment>(comments);

//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['id'] as int,
//       image: json['image'] ?? '',
//       status: json['status'] ?? '',
//       price: double.tryParse(json['price'].toString()) ?? 0.0,
//       oldPrice: double.tryParse(json['oldPrice'].toString()) ?? 0.0,
//       size: json['size'] ?? '',
//       name: json['name'] ?? '',
//       markerName: json['markerName'] ?? '',
//       category: json['category'] ?? '',
//       rating: json['rating'],
//       comments: (json['comments'] as List)
//           .map((comment) => Comment.fromJson(comment))
//           .toList(),
//       details: json['details'] ?? '',
//     );
//   }
// }
import 'package:bazaartech/model/commentmodel.dart';
import 'package:get/get.dart';

class Product {
  final int id;
  String image;
  final String status;
  final double price;
  final double oldPrice;
  final String name;
  final String size;
  final String markerName;
  final int rating;
  final String category;
  final RxList<Comment> comments;
  final String details;
  int userRate;

  Product({
    required this.id,
    required this.image,
    required this.status,
    required this.price,
    required this.oldPrice,
    required this.name,
    required this.markerName,
    required this.size,
    required this.category,
    required this.rating,
    this.userRate = 0,
    required List<Comment> comments,
    required this.details,
  }) : comments = RxList<Comment>(comments);

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      image: json['image'] ?? '',
      status: json['status'] ?? '',
      price: double.tryParse(json['price']?.toString() ?? '') ?? 0.0,
      oldPrice: double.tryParse(json['oldPrice']?.toString() ?? '') ?? 0.0,
      size: json['size'] ?? '',
      name: json['name'] ?? '',
      markerName: json['markerName'] ?? '',
      category: json['category'] ?? '',
      rating: json['rating'] ?? 0,
      comments: json['comments'] != null
          ? (json['comments'] as List)
              .map((comment) => Comment.fromJson(comment))
              .toList()
          : [],
      details: json['details'] ?? '',
      userRate: json['userRate'] ?? 0,
    );
  }
}
