// To parse this JSON data, do
//
//     final registerSuccessResponse = registerSuccessResponseFromJson(jsonString);

import 'dart:convert';

RegisterSuccessResponse registerSuccessResponseFromJson(String str) => RegisterSuccessResponse.fromJson(json.decode(str));

String registerSuccessResponseToJson(RegisterSuccessResponse data) => json.encode(data.toJson());

class RegisterSuccessResponse {
  RegisterSuccessResponse({
    this.accessToken,
    this.tokenType,
    this.expiresAt,
  });

  String accessToken;
  String tokenType;
  DateTime expiresAt;

  factory RegisterSuccessResponse.fromJson(Map<String, dynamic> json) => RegisterSuccessResponse(
    accessToken: json["access_token"],
    tokenType: json["token_type"],
    expiresAt: DateTime.parse(json["expires_at"]),
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "token_type": tokenType,
    "expires_at": expiresAt.toIso8601String(),
  };
}
