// To parse this JSON data, do
//
//     final commentsResponse = commentsResponseFromJson(jsonString);

import 'dart:convert';

CommentsResponse commentsResponseFromJson(String str) => CommentsResponse.fromJson(json.decode(str));

String commentsResponseToJson(CommentsResponse data) => json.encode(data.toJson());

class CommentsResponse {
  CommentsResponse({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int currentPage;
  List<Comment> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory CommentsResponse.fromJson(Map<String, dynamic> json) => CommentsResponse(
    currentPage: json["current_page"],
    data: List<Comment>.from(json["data"].map((x) => Comment.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };

  @override
  String toString() {
    return 'CommentsResponse{currentPage: $currentPage, data: $data, firstPageUrl: $firstPageUrl, from: $from, lastPage: $lastPage, lastPageUrl: $lastPageUrl, nextPageUrl: $nextPageUrl, path: $path, perPage: $perPage, prevPageUrl: $prevPageUrl, to: $to, total: $total}';
  }
}

class Comment {
  Comment({
    this.id,
    this.comment,
    this.createdAt,
    this.humanTime,
    this.totalLikes,
    this.isLiked
  });

  int id;
  String comment;
  DateTime createdAt;
  String humanTime;
  int totalLikes;
  bool isLiked;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["id"],
    comment: json["comment"],
    createdAt: DateTime.parse(json["created_at"]),
    humanTime: json["human_time"],
    totalLikes: json["total_likes"],
    isLiked: json["is_liked"]
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "comment": comment,
    "created_at": createdAt.toIso8601String(),
    "human_time": humanTime,
    "total_likes": totalLikes,
    "is_liked": isLiked
  };

  @override
  String toString() {
    return 'Comment{id: $id, comment: $comment, createdAt: $createdAt, humanTime: $humanTime, totalLikes: $totalLikes}';
  }
}
