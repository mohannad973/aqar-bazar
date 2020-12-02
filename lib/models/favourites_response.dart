// To parse this JSON data, do
//
//     final favouritesResponse = favouritesResponseFromJson(jsonString);

import 'dart:convert';

import 'package:aqar_bazar/screens/filter/search_result_model.dart';

UserFavouritesResponse userFavouritesResponseFromJson(String str) => UserFavouritesResponse.fromJson(json.decode(str));

String userFavouritesResponseToJson(UserFavouritesResponse data) => json.encode(data.toJson());

class UserFavouritesResponse {
  UserFavouritesResponse({
    this.data,
    this.links,
    this.meta,
  });

  List<Datum> data;
  Links links;
  Meta meta;

  factory UserFavouritesResponse.fromJson(Map<String, dynamic> json) => UserFavouritesResponse(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "links": links.toJson(),
    "meta": meta.toJson(),
  };
}



