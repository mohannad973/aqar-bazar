// To parse this JSON data, do
//
//     final registerErrorResponse = registerErrorResponseFromJson(jsonString);

import 'dart:convert';

RegisterErrorResponse registerErrorResponseFromJson(String str) => RegisterErrorResponse.fromJson(json.decode(str));

String registerErrorResponseToJson(RegisterErrorResponse data) => json.encode(data.toJson());

class RegisterErrorResponse {
  RegisterErrorResponse({
    this.message,
    this.errors,
  });

  String message;
  Errors errors;

  factory RegisterErrorResponse.fromJson(Map<String, dynamic> json) => RegisterErrorResponse(
    message: json["message"],
    errors: Errors.fromJson(json["errors"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "errors": errors.toJson(),
  };
}

class Errors {
  Errors({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
  });

  List<String> firstName;
  List<String> lastName;
  List<String> email;
  List<String> password;

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    firstName: List<String>.from(json["first_name"].map((x) => x)),
    lastName: List<String>.from(json["last_name"].map((x) => x)),
    email: List<String>.from(json["email"].map((x) => x)),
    password: List<String>.from(json["password"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "first_name": List<dynamic>.from(firstName.map((x) => x)),
    "last_name": List<dynamic>.from(lastName.map((x) => x)),
    "email": List<dynamic>.from(email.map((x) => x)),
    "password": List<dynamic>.from(password.map((x) => x)),
  };
}
