import 'package:bazaartech/model/commentmodel.dart';
import 'package:bazaartech/view/home/model/productmodel.dart';
import 'package:get/get.dart';

class Bazaar {
  final String id;
  final String image;
  final String name;
  final String details;
  final String firstDate;
  final int userRate;
  final String lastDate;
  final String status;
  final List<Product> products;
  final RxList<Comment> reviews;

  Bazaar(
      {required List<Comment> reviews,
      required this.id,
      required this.image,
      required this.name,
      required this.details,
      required this.firstDate,
      required this.userRate,
      required this.lastDate,
      required this.status,
      required this.products})
      : reviews = reviews = RxList<Comment>(reviews);
}
