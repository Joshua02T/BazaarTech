import 'dart:ffi';

import 'package:bazaartech/view/home/model/categorymodel.dart';
import 'package:bazaartech/view/home/model/commentmodel.dart';
import 'package:bazaartech/view/home/model/productmodel.dart';
import 'package:get/get.dart';

class Store {
  final int id;
  String image;
  final String sort;
  final int rating;
  final String name;
  final String address;
  final String storeNumber;
  final int userRate;
  final double latitude;
  final double longitude;
  final List<Product> products;
  final RxList<Comment> reviews;
  final List<Category> categories;

  Store({
    required this.id,
    required this.image,
    required this.sort,
    required this.rating,
    required this.name,
    required this.storeNumber,
    required this.address,
    required this.userRate,
    required this.latitude,
    required this.longitude,
    required this.products,
    required this.reviews,
    required this.categories,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'],
      image: json['image'] ?? '',
      sort: json['sort'] ?? '',
      rating: json['rating'] ?? 0,
      name: json['name'] ?? '',
      storeNumber: json['storeNumber'] ?? '',
      address: json['address'] ?? '',
      userRate: json['userRate'] ?? 0,
      latitude: double.tryParse(json['latitude'].toString()) ?? 0.0,
      longitude: double.tryParse(json['longitude'].toString()) ?? 0.0,
      products: (json['products'] as List<dynamic>? ?? [])
          .map((e) => Product.fromJson(e))
          .toList(),
      reviews: RxList<Comment>(
        (json['reviews'] as List<dynamic>? ?? [])
            .map((e) => Comment.fromJson(e))
            .toList(),
      ),
      categories: (json['categories'] as List<dynamic>? ?? [])
          .map((e) => Category.fromJson(e))
          .toList(),
    );
  }
}
