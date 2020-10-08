// To parse this JSON data, do
//
//     final searchResultMode = searchResultModeFromJson(jsonString);

import 'dart:convert';

SearchResultModel searchResultModeFromJson(String str) =>
    SearchResultModel.fromJson(json.decode(str));

String searchResultModeToJson(SearchResultModel data) =>
    json.encode(data.toJson());

class SearchResultModel {
  SearchResultModel({
    this.data,
    this.links,
    this.meta,
  });

  List<Datum> data;
  Links links;
  Meta meta;

  factory SearchResultModel.fromJson(Map<String, dynamic> json) =>
      SearchResultModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        links: Links.fromJson(json["links"]),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "links": links.toJson(),
        "meta": meta.toJson(),
      };

  @override
  String toString() {
    return 'SearchResultModel{data: $data, links: $links, meta: $meta}';
  }
}

class Datum {
  Datum({
    this.id,
    this.title,
    this.thumbnail,
    this.rate,
    this.address,
    this.price,
    this.viewLink,
    this.createdAt,
    this.promoteLink,
  });

  int id;
  String title;
  String thumbnail;
  int rate;
  String address;
  int price;
  String viewLink;
  String createdAt;
  String promoteLink;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        thumbnail: json["thumbnail"],
        rate: json["rate"],
        address: json["address"],
        price: json["price"],
        viewLink: json["view_link"],
        createdAt: json["created_at"],
        promoteLink: json["promote_link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "thumbnail": thumbnail,
        "rate": rate,
        "address": address,
        "price": price,
        "view_link": viewLink,
        "created_at": createdAt,
        "promote_link": promoteLink,
      };

  @override
  String toString() {
    return 'Datum{id: $id, title: $title, thumbnail: $thumbnail, rate: $rate, address: $address, price: $price, viewLink: $viewLink, createdAt: $createdAt, promoteLink: $promoteLink}';
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
  String prev;
  dynamic next;

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
}
