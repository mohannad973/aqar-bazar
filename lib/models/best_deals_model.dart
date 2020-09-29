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
  final numOfRooms;
  final numOfBeds;
  final numOfBathRooms;
  final cleaning;
  final security;
  final cameras;

  final view;
  final parking;
  final space;
  final numOfKitchens;

  Property(
      {this.numOfRooms,
      this.numOfBeds,
      this.numOfBathRooms,
      this.cleaning,
      this.security,
      this.view,
      this.parking,
      this.numOfKitchens,
      this.space,
      this.image,
      this.moreImages,
      this.cameras,
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
      numOfBathRooms: 2,
      cameras: true,
      numOfKitchens: 1,
      numOfBeds: 4,
      numOfRooms: 2,
      security: true,
      cleaning: true,
      parking: true,
      view: true,
      space: '200'),
  Property(
      image: 'assets/images/explore_list_images/hotel2.png',
      location: 'City Center',
      price: '\$ 400',
      rating: 'Highly recomended',
      shortAddress: 'Nassau,Bahamas',
      cameras: true,
      name: 'A great place to rent',
      moreImages: [
        'assets/images/explore_list_images/hotel11.jpg',
        'assets/images/explore_list_images/hotel12.jpg',
        'assets/images/explore_list_images/hotel13.jpg',
        'assets/images/explore_list_images/hotel14.jpg'
      ],
      propertType: 1,
      numOfBathRooms: 2,
      numOfBeds: 4,
      numOfRooms: 2,
      numOfKitchens: 1,
      security: true,
      cleaning: true,
      parking: true,
      view: true,
      space: '200'),
  Property(
      image: 'assets/images/building2.jpg',
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
      cameras: true,
      numOfBathRooms: 2,
      numOfKitchens: 1,
      numOfBeds: 4,
      numOfRooms: 2,
      security: true,
      cleaning: true,
      parking: true,
      view: true,
      space: '200'),
  Property(
      image: 'assets/images/beechwood-home.png',
      location: 'City Center',
      price: '\$ 400',
      rating: 'Highly recomended',
      cameras: true,
      moreImages: [
        'assets/images/explore_list_images/hotel11.jpg',
        'assets/images/explore_list_images/hotel12.jpg',
        'assets/images/explore_list_images/hotel13.jpg',
        'assets/images/explore_list_images/hotel14.jpg'
      ],
      shortAddress: 'Nassau,Bahamas',
      name: 'A great place to rent',
      propertType: '1',
      numOfBathRooms: '2',
      numOfBeds: '4',
      numOfRooms: '2',
      security: true,
      cleaning: true,
      numOfKitchens: 1,
      parking: true,
      view: true,
      space: '200'),
];
