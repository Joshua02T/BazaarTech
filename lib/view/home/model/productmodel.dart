import 'package:get/get.dart';

class Product {
  final String id;
  final String image;
  final String status;
  final int price;
  final int oldPrice;
  final String name;
  final String size;
  final String markerName;
  final double rating;
  final String category;
  final RxList<Comment> comments;
  final String details;
  final int userRate;

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
    required this.userRate,
    required List<Comment> comments,
    required this.details,
  }) : comments = RxList<Comment>(comments);

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        image: json['image'],
        status: json['status'],
        price: json['price'],
        oldPrice: json['oldPrice'],
        size: json['size'],
        name: json['name'],
        markerName: json['storeName'],
        category: json['category'],
        rating: (json['rating'] as num).toDouble(),
        comments: (json['comments'] as List)
            .map((comment) => Comment.fromJson(comment))
            .toList(),
        details: json['details'],
        userRate: json['userRate']);
  }
}

class Comment {
  final String profilePhoto;
  final String name;
  final double rating;
  final String comment;
  int likes;
  bool isLiked;
  Comment(
      {required this.profilePhoto,
      required this.name,
      required this.rating,
      required this.comment,
      required this.likes,
      this.isLiked = false});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        profilePhoto: json['profilePhoto'],
        name: json['name'],
        rating: (json['rating'] as num).toDouble(),
        comment: json['comment'],
        likes: (json['likes'] as num).toInt());
  }
}
