import 'package:bazaartech/model/categorymodel.dart';
import 'package:bazaartech/model/commentmodel.dart';
import 'package:bazaartech/view/home/model/productmodel.dart';
import 'package:get/get.dart';

class Bazaar {
  final int id;
  String image;
  final String name;
  final String details;
  final String firstDate;
  int userRate;
  bool isFavorite;
  final String lastDate;
  final String address;
  final String status;
  final List<Product> products;
  final RxList<Comment> comments;
  final List<Category> categories;

  Bazaar(
      {required this.id,
      required this.address,
      required this.image,
      required this.name,
      required this.details,
      required this.firstDate,
      this.userRate = 0,
      required this.isFavorite,
      required this.lastDate,
      required this.status,
      required this.comments,
      required this.categories,
      required this.products});

  factory Bazaar.fromJson(Map<String, dynamic> json) {
    return Bazaar(
        comments: RxList<Comment>(
          json['reviews'] != null
              ? (json['reviews'] as List)
                  .map((e) => Comment.fromJson(e))
                  .toList()
              : [],
        ),
        id: json['id'],
        address: json['address'] ?? '',
        image: json['image'] ?? '',
        name: json['name'] ?? '',
        isFavorite: json['isFavorite'],
        details: json['details'] ?? '',
        firstDate: json['firstDate'] ?? '',
        lastDate: json['lastDate'] ?? '',
        status: json['status'] ?? '',
        categories: json['categories'] != null
            ? (json['categories'] as List)
                .map((e) => Category.fromJson(e))
                .toList()
            : [],
        products: json['products'] != null
            ? (json['products'] as List)
                .map((e) => Product.fromJson(e))
                .toList()
            : []);
  }
}
