// To parse this JSON data, do
//
//     final userRequestsResponse = userRequestsResponseFromJson(jsonString);

import 'dart:convert';

UserRequestsResponse userRequestsResponseFromJson(String str) => UserRequestsResponse.fromJson(json.decode(str));

String userRequestsResponseToJson(UserRequestsResponse data) => json.encode(data.toJson());

class UserRequestsResponse {
  UserRequestsResponse({
    this.request,
    this.links,
    this.meta,
  });

  List<Request> request;
  Links links;
  Meta meta;

  factory UserRequestsResponse.fromJson(Map<String, dynamic> json) => UserRequestsResponse(
    request: List<Request>.from(json["data"].map((x) => Request.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(request.map((x) => x.toJson())),
    "links": links.toJson(),
    "meta": meta.toJson(),
  };

  @override
  String toString() {
    return 'UserRequestsResponse{request: $request, links: $links, meta: $meta}';
  }
}

class Request {
  Request({
    this.id,
    this.title,
    this.thumbnail,
    this.status,
    this.amount,
    this.from,
    this.to,
    this.payNow,
    this.cancel,
  });

  int id;
  String title;
  String thumbnail;
  String status;
  int amount;
  DateTime from;
  DateTime to;
  String payNow;
  String cancel;

  factory Request.fromJson(Map<String, dynamic> json) => Request(
    id: json["id"],
    title: json["title"],
    thumbnail: json["thumbnail"],
    status: json["status"],
    amount: json["amount"],
    from: json["from"] == null ? null : DateTime.parse(json["from"]),
    to: json["to"] == null ? null : DateTime.parse(json["to"]),
    payNow: json["pay_now"] == null ? null : json["pay_now"],
    cancel: json["cancel"] == null ? null : json["cancel"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "thumbnail": thumbnail,
    "status": status,
    "amount": amount,
    "from": from == null ? null : "${from.year.toString().padLeft(4, '0')}-${from.month.toString().padLeft(2, '0')}-${from.day.toString().padLeft(2, '0')}",
    "to": to == null ? null : "${to.year.toString().padLeft(4, '0')}-${to.month.toString().padLeft(2, '0')}-${to.day.toString().padLeft(2, '0')}",
    "pay_now": payNow == null ? null : payNow,
    "cancel": cancel == null ? null : cancel,
  };

  @override
  String toString() {
    return 'Request{id: $id, title: $title, thumbnail: $thumbnail, status: $status, amount: $amount, from: $from, to: $to, payNow: $payNow, cancel: $cancel}';
  }
}

class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  String first;
  String last;
  dynamic prev;
  String next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };

  @override
  String toString() {
    return 'Links{first: $first, last: $last, prev: $prev, next: $next}';
  }
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  int currentPage;
  int from;
  int lastPage;
  String path;
  int perPage;
  int to;
  int total;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };

  @override
  String toString() {
    return 'Meta{currentPage: $currentPage, from: $from, lastPage: $lastPage, path: $path, perPage: $perPage, to: $to, total: $total}';
  }
}
