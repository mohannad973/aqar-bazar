// To parse this JSON data, do
//
//     final userProfileResponse = userProfileResponseFromJson(jsonString);

import 'dart:convert';

UserProfileResponse userProfileResponseFromJson(String str) => UserProfileResponse.fromJson(json.decode(str));

String userProfileResponseToJson(UserProfileResponse data) => json.encode(data.toJson());

class UserProfileResponse {
  UserProfileResponse({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.languageId,
    this.type,
    this.gender,
    this.email,
    this.mobileNumber,
    this.profilePicture,
    this.countryId,
    this.cityId,
    this.verified,
    this.status,
    this.lastLogin,
    this.createdBy,
    this.modifiedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int id;
  String firstName;
  String lastName;
  dynamic username;
  int languageId;
  String type;
  String gender;
  String email;
  dynamic mobileNumber;
  dynamic profilePicture;
  dynamic countryId;
  dynamic cityId;
  int verified;
  int status;
  dynamic lastLogin;
  dynamic createdBy;
  dynamic modifiedBy;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) => UserProfileResponse(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    username: json["username"],
    languageId: json["language_id"],
    type: json["type"],
    gender: json["gender"],
    email: json["email"],
    mobileNumber: json["mobile_number"],
    profilePicture: json["profile_picture"],
    countryId: json["country_id"],
    cityId: json["city_id"],
    verified: json["verified"],
    status: json["status"],
    lastLogin: json["last_login"],
    createdBy: json["created_by"],
    modifiedBy: json["modified_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "username": username,
    "language_id": languageId,
    "type": type,
    "gender": gender,
    "email": email,
    "mobile_number": mobileNumber,
    "profile_picture": profilePicture,
    "country_id": countryId,
    "city_id": cityId,
    "verified": verified,
    "status": status,
    "last_login": lastLogin,
    "created_by": createdBy,
    "modified_by": modifiedBy,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
  };

  @override
  String toString() {
    return 'UserProfileResponse{id: $id, firstName: $firstName, lastName: $lastName, username: $username, languageId: $languageId, type: $type, gender: $gender, email: $email, mobileNumber: $mobileNumber, profilePicture: $profilePicture, countryId: $countryId, cityId: $cityId, verified: $verified, status: $status, lastLogin: $lastLogin, createdBy: $createdBy, modifiedBy: $modifiedBy, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt}';
  }
}
