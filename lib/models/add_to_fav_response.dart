// To parse this JSON data, do
//
//     final addToFavResponse = addToFavResponseFromJson(jsonString);

import 'dart:convert';

AddToFavResponse addToFavResponseFromJson(String str) => AddToFavResponse.fromJson(json.decode(str));

String addToFavResponseToJson(AddToFavResponse data) => json.encode(data.toJson());

class AddToFavResponse {
  AddToFavResponse({
    this.success,
    this.btn,
  });

  String success;
  String btn;

  factory AddToFavResponse.fromJson(Map<String, dynamic> json) => AddToFavResponse(
    success: json["success"],
    btn: json["btn"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "btn": btn,
  };
}
