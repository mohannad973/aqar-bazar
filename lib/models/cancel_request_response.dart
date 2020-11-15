// To parse this JSON data, do
//
//     final cancelRequestResponse = cancelRequestResponseFromJson(jsonString);

import 'dart:convert';

import 'package:aqar_bazar/screens/filter/search_result_model.dart';

CancelRequestResponse cancelRequestResponseFromJson(String str) => CancelRequestResponse.fromJson(json.decode(str));

String cancelRequestResponseToJson(CancelRequestResponse data) => json.encode(data.toJson());

class CancelRequestResponse {
  CancelRequestResponse({
    this.data,
    this.links,
    this.meta,
    this.message,
  });

  List<Datum> data;
  Links links;
  Meta meta;
  String message;

  factory CancelRequestResponse.fromJson(Map<String, dynamic> json) => CancelRequestResponse(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "links": links.toJson(),
    "meta": meta.toJson(),
    "message": message,
  };
}


