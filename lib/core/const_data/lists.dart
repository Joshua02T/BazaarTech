import 'package:bazaartech/core/const_data/app_image.dart';
import 'package:bazaartech/view/home/model/bazaarmodel.dart';
import 'package:bazaartech/view/home/model/commentmodel.dart';

List categoryItem = ['All', 'Products', 'Stores', 'Bazaars'];

List searchCategoryItem = ['Products', 'Stores', 'Bazaars'];

List ratingNumbers = ['1', '2', '3', '4', '5'];

List bazaarStatus = ['past', 'ongoing', 'upcoming'];

final List<Bazaar> bazaarCardItems = [
  Bazaar(
    id: "bazaar1",
    image: AppImages.bazaarimage1,
    name: 'Christmas Al-Hadara',
    details: 'Sales up to %70 !!',
    firstDate: '1 Oct',
    lastDate: '10 Oct',
    userRate: 1,
    status: 'online',
    reviews: [
      Comment(
          profilePhoto: AppImages.user1,
          name: 'John Doe',
          rating: 4,
          comment: 'Great boots! Very comfortable and lightweight.',
          likes: 0,
          id: 0,
          isLiked: false),
      Comment(
          profilePhoto: AppImages.user2,
          name: 'Jane Smith',
          rating: 5,
          comment: 'Amazing quality and perfect fit. Highly recommend!',
          likes: 0,
          id: 1,
          isLiked: false),
    ],
    products: [],
  ),
  Bazaar(
      id: "bazaar2",
      image: AppImages.bazaarimage2,
      name: 'New Year',
      details: 'New Year’s sales and many other things!!',
      firstDate: '25 Dec',
      userRate: 0,
      lastDate: '30 Dec',
      status: '',
      reviews: [],
      products: []),
];
