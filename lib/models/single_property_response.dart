// To parse this JSON data, do
//
//     final singlePropertyResponse = singlePropertyResponseFromJson(jsonString);

import 'dart:convert';

SinglePropertyResponse singlePropertyResponseFromJson(String str) => SinglePropertyResponse.fromJson(json.decode(str));

String singlePropertyResponseToJson(SinglePropertyResponse data) => json.encode(data.toJson());

class SinglePropertyResponse {
  SinglePropertyResponse({
    this.data,
  });

  SingleProperty data;

  factory SinglePropertyResponse.fromJson(Map<String, dynamic> json) => SinglePropertyResponse(
    data: SingleProperty.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };

  @override
  String toString() {
    return 'SinglePropertyResponse{data: $data}';
  }
}

class SingleProperty {
  SingleProperty({
    this.id,
    this.title,
    this.description,
    this.thumbnail,
    this.attachments,
    this.totalRate,
    this.address,
    this.price,
    this.bedroomsNumber,
    this.bathroomsNumber,
    this.sellingType,
    this.ratio,
    this.createdAt,
    this.webRoute,
    this.favoriteRoute,
    this.favoriteBtnTxt,
    this.isBooked,
  });

  int id;
  String title;
  String description;
  String thumbnail;
  List<String> attachments;
  int totalRate;
  String address;
  int price;
  int bedroomsNumber;
  int bathroomsNumber;
  int sellingType;
  int ratio;
  String createdAt;
  String webRoute;
  String favoriteRoute;
  String favoriteBtnTxt;
  bool isBooked;

  factory SingleProperty.fromJson(Map<String, dynamic> json) => SingleProperty(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    thumbnail: json["thumbnail"],
    attachments: List<String>.from(json["attachments"].map((x) => x)),
    totalRate: json["total_rate"],
    address: json["address"],
    price: json["price"],
    bedroomsNumber: json["bedrooms_number"],
    bathroomsNumber: json["bathrooms_number"],
    sellingType: json["selling_type"],
    ratio: json["ratio"],
    createdAt: json["created_at"],
    webRoute: json["web_route"],
    favoriteRoute: json["favorite_route"],
    favoriteBtnTxt: json["favoriteBtnTxt"],
    isBooked: json["isBooked"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "thumbnail": thumbnail,
    "attachments": List<dynamic>.from(attachments.map((x) => x)),
    "total_rate": totalRate,
    "address": address,
    "price": price,
    "bedrooms_number": bedroomsNumber,
    "bathrooms_number": bathroomsNumber,
    "selling_type": sellingType,
    "ratio": ratio,
    "created_at": createdAt,
    "web_route": webRoute,
    "favorite_route": favoriteRoute,
    "favoriteBtnTxt": favoriteBtnTxt,
    "isBooked": isBooked,
  };

  @override
  String toString() {
    return 'SingleProperty{id: $id, title: $title, description: $description, thumbnail: $thumbnail, attachments: $attachments, totalRate: $totalRate, address: $address, price: $price, bedroomsNumber: $bedroomsNumber, bathroomsNumber: $bathroomsNumber, sellingType: $sellingType, ratio: $ratio, createdAt: $createdAt, webRoute: $webRoute, favoriteRoute: $favoriteRoute, favoriteBtnTxt: $favoriteBtnTxt, isBooked: $isBooked}';
  }
}
