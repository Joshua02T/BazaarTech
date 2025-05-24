import 'package:bazaartech/view/home/model/productmodel.dart';
import 'package:get/get.dart';

class Store {
  final String id;
  final String image;
  final String sort;
  final double rating;
  final String name;
  final String address;
  final int storeNumber;
  final double latitude;
  final double longitude;
  final List<Product> products;
  final RxList<Review> reviews;

  Store(
      {required List<Review> reviews,
      required this.id,
      required this.image,
      required this.sort,
      required this.rating,
      required this.name,
      required this.storeNumber,
      required this.address,
      required this.latitude,
      required this.longitude,
      required this.products})
      : reviews = reviews = RxList<Review>(reviews);
}

class Review {
  final String profilePhoto;
  final String name;
  final double rating;
  final String review;

  Review({
    required this.profilePhoto,
    required this.name,
    required this.rating,
    required this.review,
  });
}
