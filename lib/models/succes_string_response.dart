

import 'dart:convert';

SuccessStringResponse successStringResponseFromJson(String str) => SuccessStringResponse.fromJson(json.decode(str));

String successStringResponseToJson(SuccessStringResponse data) => json.encode(data.toJson());

class SuccessStringResponse {
  SuccessStringResponse({
    this.success,
  });

  String success;

  factory SuccessStringResponse.fromJson(Map<String, dynamic> json) => SuccessStringResponse(
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
  };

  @override
  String toString() {
    return 'SuccessStringResponse{success: $success}';
  }
}
