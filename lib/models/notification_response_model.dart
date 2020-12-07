// To parse this JSON data, do
//
//     final notificationResponse = notificationResponseFromJson(jsonString);

import 'dart:convert';

List<NotificationResponse> notificationResponseFromJson(String str) => List<NotificationResponse>.from(json.decode(str).map((x) => NotificationResponse.fromJson(x)));

String notificationResponseToJson(List<NotificationResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationResponse {
  NotificationResponse({
    this.id,
    this.type,
    this.notifiableId,
    this.notifiableType,
    this.data,
    this.readAt,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String type;
  int notifiableId;
  String notifiableType;
  Data data;
  dynamic readAt;
  DateTime createdAt;
  DateTime updatedAt;

  factory NotificationResponse.fromJson(Map<String, dynamic> json) => NotificationResponse(
    id: json["id"],
    type: json["type"],
    notifiableId: json["notifiable_id"],
    notifiableType: json["notifiable_type"],
    data: Data.fromJson(json["data"]),
    readAt: json["read_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "notifiable_id": notifiableId,
    "notifiable_type": notifiableType,
    "data": data.toJson(),
    "read_at": readAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };

  @override
  String toString() {
    return 'NotificationResponse{id: $id, type: $type, notifiableId: $notifiableId, notifiableType: $notifiableType, data: $data, readAt: $readAt, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}

class Data {
  Data({
    this.propertyId,
    this.head,
    this.bodyEn,
    this.bodyTr,
    this.bodyAr,
    this.request,
    this.time,
  });

  int propertyId;
  String head;
  String bodyEn;
  String bodyTr;
  String bodyAr;
  String request;
  DateTime time;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    propertyId: json["property_id"] == null ? null : json["property_id"],
    head: json["head"],
    bodyEn: json["body_en"],
    bodyTr: json["body_tr"],
    bodyAr: json["body_ar"],
    request: json["request"],
    time: DateTime.parse(json["time"]),
  );

  Map<String, dynamic> toJson() => {
    "property_id": propertyId == null ? null : propertyId,
    "head": head,
    "body_en": bodyEn,
    "body_tr": bodyTr,
    "body_ar": bodyAr,
    "request": request,
    "time": time.toIso8601String(),
  };

  @override
  String toString() {
    return 'Data{propertyId: $propertyId, head: $head, bodyEn: $bodyEn, bodyTr: $bodyTr, bodyAr: $bodyAr, request: $request, time: $time}';
  }
}
