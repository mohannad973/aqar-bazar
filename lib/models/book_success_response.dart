// To parse this JSON data, do
//
//     final bookSuccessResponse = bookSuccessResponseFromJson(jsonString);

import 'dart:convert';

BookSuccessResponse bookSuccessResponseFromJson(String str) => BookSuccessResponse.fromJson(json.decode(str));

String bookSuccessResponseToJson(BookSuccessResponse data) => json.encode(data.toJson());

class BookSuccessResponse {
  BookSuccessResponse({
    this.message,
  });

  String message;

  factory BookSuccessResponse.fromJson(Map<String, dynamic> json) => BookSuccessResponse(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
