// To parse this JSON data, do
//
//     final propertyParametersModel = propertyParametersModelFromJson(jsonString);

import 'dart:convert';

PropertyParametersModel propertyParametersModelFromJson(String str) => PropertyParametersModel.fromJson(json.decode(str));

String propertyParametersModelToJson(PropertyParametersModel data) => json.encode(data.toJson());

class PropertyParametersModel {
  PropertyParametersModel({
    this.categories,
    this.cities,
    this.statues,
    this.sellingTypes,
    this.propertyUnits,
    this.countries2,
    this.ads,
    this.ratio,
  });

  List<List<dynamic>> categories;
  List<List<dynamic>> cities;
  List<List<dynamic>> statues;
  List<List<dynamic>> sellingTypes;
  List<List<dynamic>> propertyUnits;
  List<List<dynamic>> countries2;
  List<List<dynamic>> ads;
  List<List<dynamic>> ratio;

  factory PropertyParametersModel.fromJson(Map<String, dynamic> json) => PropertyParametersModel(
    categories: List<List<dynamic>>.from(json["categories"].map((x) => List<dynamic>.from(x.map((x) => x)))),
    cities: List<List<dynamic>>.from(json["cities"].map((x) => List<dynamic>.from(x.map((x) => x)))),
    statues: List<List<dynamic>>.from(json["statues"].map((x) => List<dynamic>.from(x.map((x) => x)))),
    sellingTypes: List<List<dynamic>>.from(json["selling_types"].map((x) => List<dynamic>.from(x.map((x) => x)))),
    propertyUnits: List<List<dynamic>>.from(json["property_units"].map((x) => List<dynamic>.from(x.map((x) => x)))),
    countries2: List<List<dynamic>>.from(json["countries2"].map((x) => List<dynamic>.from(x.map((x) => x)))),
    ads: List<List<dynamic>>.from(json["ads"].map((x) => List<dynamic>.from(x.map((x) => x)))),
    ratio: List<List<dynamic>>.from(json["ratio"].map((x) => List<dynamic>.from(x.map((x) => x)))),
  );

  Map<String, dynamic> toJson() => {
    "categories": List<dynamic>.from(categories.map((x) => List<dynamic>.from(x.map((x) => x)))),
    "cities": List<dynamic>.from(cities.map((x) => List<dynamic>.from(x.map((x) => x)))),
    "statues": List<dynamic>.from(statues.map((x) => List<dynamic>.from(x.map((x) => x)))),
    "selling_types": List<dynamic>.from(sellingTypes.map((x) => List<dynamic>.from(x.map((x) => x)))),
    "property_units": List<dynamic>.from(propertyUnits.map((x) => List<dynamic>.from(x.map((x) => x)))),
    "countries2": List<dynamic>.from(countries2.map((x) => List<dynamic>.from(x.map((x) => x)))),
    "ads": List<dynamic>.from(ads.map((x) => List<dynamic>.from(x.map((x) => x)))),
    "ratio": List<dynamic>.from(ratio.map((x) => List<dynamic>.from(x.map((x) => x)))),
  };

  @override
  String toString() {
    return 'PropertyParametersModel{categories: $categories, cities: $cities, statues: $statues, sellingTypes: $sellingTypes, propertyUnits: $propertyUnits, countries2: $countries2, ads: $ads, ratio: $ratio}';
  }
}

class Category{
  String name;
  int id;

  Category({this.name, this.id});

  @override
  String toString() {
    return 'Category{name: $name, id: $id}';
  }
}
