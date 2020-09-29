import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Property {
  final image;
  final name;
  final price;
  final rating;
  final shortAddress;
  final location;
  final moreImages;
  final propertType;

  Property(
      {this.image,
      this.moreImages,
      this.location,
      this.price,
      this.name,
      this.rating,
      this.propertType,
      this.shortAddress});
}

List<Property> bestDeals = [
  Property(
    image: 'assets/images/explore_list_images/hotel1.png',
    location: '4.0 km from the city',
    price: '\$ 2000',
    rating: 'Highly recomended',
    shortAddress: 'Nassau, Bahamas',
    name: 'Beach Hotel',
    moreImages: [
      'assets/images/explore_list_images/hotel11.jpg',
      'assets/images/explore_list_images/hotel12.jpg',
      'assets/images/explore_list_images/hotel13.jpg',
      'assets/images/explore_list_images/hotel14.jpg'
    ],
    propertType: Icon(Icons.code),
  ),
  Property(
    image: 'assets/images/explore_list_images/hotel2.png',
    location: 'City Center',
    price: '\$ 400',
    rating: 'Highly recomended',
    shortAddress: 'Nassau,Bahamas',
    name: 'A great place to rent',
    moreImages: [
      'assets/images/explore_list_images/hotel11.jpg',
      'assets/images/explore_list_images/hotel12.jpg',
      'assets/images/explore_list_images/hotel13.jpg',
      'assets/images/explore_list_images/hotel14.jpg'
    ],
    propertType: 1,
  ),
  Property(
    image: 'assets/images/explore_list_images/hotel2.png',
    location: 'City Center',
    price: '\$ 400',
    rating: 'Highly recomended',
    moreImages: [
      'assets/images/explore_list_images/hotel11.jpg',
      'assets/images/explore_list_images/hotel12.jpg',
      'assets/images/explore_list_images/hotel13.jpg',
      'assets/images/explore_list_images/hotel14.jpg'
    ],
    shortAddress: 'Nassau,Bahamas',
    name: 'A great place to rent',
    propertType: 1,
  ),
  Property(
    image: 'assets/images/explore_list_images/hotel2.png',
    location: 'City Center',
    price: '\$ 400',
    rating: 'Highly recomended',
    moreImages: [
      'assets/images/explore_list_images/hotel11.jpg',
      'assets/images/explore_list_images/hotel12.jpg',
      'assets/images/explore_list_images/hotel13.jpg',
      'assets/images/explore_list_images/hotel14.jpg'
    ],
    shortAddress: 'Nassau,Bahamas',
    name: 'A great place to rent',
    propertType: 1,
  ),
];
