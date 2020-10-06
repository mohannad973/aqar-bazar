// To parse this JSON data, do
//
//     final searchParamsModel = searchParamsModelFromJson(jsonString);

import 'dart:convert';

SearchParamsModel searchParamsModelFromJson(String str) => SearchParamsModel.fromJson(json.decode(str));

String searchParamsModelToJson(SearchParamsModel data) => json.encode(data.toJson());

class SearchParamsModel {
  SearchParamsModel({
    this.cities,
    this.priceRanges,
    this.sellingTypes,
    this.furnished,
    this.capacity,
    this.propertyType,
  });

  List<List<dynamic>> cities;
  List<List<String>> priceRanges;
  List<List<String>> sellingTypes;
  List<List<String>> furnished;
  List<List<dynamic>> capacity;
  List<List<dynamic>> propertyType;

  factory SearchParamsModel.fromJson(Map<String, dynamic> json) => SearchParamsModel(
    cities: List<List<dynamic>>.from(json["cities"].map((x) => List<dynamic>.from(x.map((x) => x)))),
    priceRanges: List<List<String>>.from(json["price_ranges"].map((x) => List<String>.from(x.map((x) => x)))),
    sellingTypes: List<List<String>>.from(json["selling_types"].map((x) => List<String>.from(x.map((x) => x)))),
    furnished: List<List<String>>.from(json["furnished"].map((x) => List<String>.from(x.map((x) => x)))),
    capacity: List<List<dynamic>>.from(json["capacity"].map((x) => List<dynamic>.from(x.map((x) => x)))),
    propertyType: List<List<dynamic>>.from(json["property_type"].map((x) => List<dynamic>.from(x.map((x) => x)))),
  );

  Map<String, dynamic> toJson() => {
    "cities": List<dynamic>.from(cities.map((x) => List<dynamic>.from(x.map((x) => x)))),
    "price_ranges": List<dynamic>.from(priceRanges.map((x) => List<dynamic>.from(x.map((x) => x)))),
    "selling_types": List<dynamic>.from(sellingTypes.map((x) => List<dynamic>.from(x.map((x) => x)))),
    "furnished": List<dynamic>.from(furnished.map((x) => List<dynamic>.from(x.map((x) => x)))),
    "capacity": List<dynamic>.from(capacity.map((x) => List<dynamic>.from(x.map((x) => x)))),
    "property_type": List<dynamic>.from(propertyType.map((x) => List<dynamic>.from(x.map((x) => x)))),
  };
}



class City{
  String name;
  int id;


  City({this.name, this.id});

  @override
  String toString() {
    return 'City{name: $name, id: $id}';
  }
}

class PriceRanges{
  String range;

  PriceRanges({this.range});

  @override
  String toString() {
    return 'PriceRanges{range: $range}';
  }
}

class SellingTypes{
  String name;
  String id;

  SellingTypes({this.name, this.id});

  @override
  String toString() {
    return 'SellingTypes{name: $name, id: $id}';
  }
}

class Furnished{
  String name;
  String id;

  Furnished({this.name, this.id});

  @override
  String toString() {
    return 'Furnished{namr: $name, id: $id}';
  }
}

class Capacity{
  String roomNumber;
  dynamic value;

  Capacity({this.roomNumber, this.value});

  @override
  String toString() {
    return 'Capacity{roomNumber: $roomNumber, value: $value}';
  }
}

class PropertyType{
  String name;
  int id;

  PropertyType({this.name, this.id});

  @override
  String toString() {
    return 'PropertyType{name: $name, id: $id}';
  }
}