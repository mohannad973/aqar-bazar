// To parse this JSON data, do
//
//     final likeComentResponse = likeComentResponseFromJson(jsonString);

import 'dart:convert';

LikeComentResponse likeComentResponseFromJson(String str) => LikeComentResponse.fromJson(json.decode(str));

String likeComentResponseToJson(LikeComentResponse data) => json.encode(data.toJson());

class LikeComentResponse {
  LikeComentResponse({
    this.likes,
    this.btn,
  });

  int likes;
  String btn ;

  factory LikeComentResponse.fromJson(Map<String, dynamic> json) => LikeComentResponse(
    likes: json["likes"],
    btn: json["btn"],
  );

  Map<String, dynamic> toJson() => {
    "likes": likes,
    "btn": btn,
  };

  @override
  String toString() {
    return 'LikeComentResponse{likes: $likes, btn: $btn}';
  }
}
