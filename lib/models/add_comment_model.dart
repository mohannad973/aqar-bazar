// To parse this JSON data, do
//
//     final addCommentResponse = addCommentResponseFromJson(jsonString);

import 'dart:convert';

AddCommentResponse addCommentResponseFromJson(String str) => AddCommentResponse.fromJson(json.decode(str));

String addCommentResponseToJson(AddCommentResponse data) => json.encode(data.toJson());

class AddCommentResponse {
  AddCommentResponse({
    this.success,
    this.comment,
  });

  String success;
  Comment comment;

  factory AddCommentResponse.fromJson(Map<String, dynamic> json) => AddCommentResponse(
    success: json["success"],
    comment: Comment.fromJson(json["comment"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "comment": comment.toJson(),
  };
}

class Comment {
  Comment({
    this.id,
    this.commentableType,
    this.commentableId,
    this.customerId,
    this.parentId,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.humanTime,
    this.totalLikes,
    this.owner,
  });

  int id;
  String commentableType;
  int commentableId;
  int customerId;
  int parentId;
  String comment;
  DateTime createdAt;
  DateTime updatedAt;
  String humanTime;
  int totalLikes;
  Owner owner;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["id"],
    commentableType: json["commentable_type"],
    commentableId: json["commentable_id"],
    customerId: json["customer_id"],
    parentId: json["parent_id"],
    comment: json["comment"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    humanTime: json["human_time"],
    totalLikes: json["total_likes"],
    owner: Owner.fromJson(json["owner"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "commentable_type": commentableType,
    "commentable_id": commentableId,
    "customer_id": customerId,
    "parent_id": parentId,
    "comment": comment,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "human_time": humanTime,
    "total_likes": totalLikes,
    "owner": owner.toJson(),
  };
}

class Owner {
  Owner({
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
  String username;
  int languageId;
  String type;
  String gender;
  String email;
  String mobileNumber;
  dynamic profilePicture;
  int countryId;
  int cityId;
  int verified;
  int status;
  dynamic lastLogin;
  dynamic createdBy;
  dynamic modifiedBy;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
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
}
