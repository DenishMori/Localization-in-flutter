import 'dart:convert';
List<Post> postFromJson(String str) => List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  String title;
  int id;
  int userId;
  String body;

  Post(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body});

  factory Post.fromJson(Map<String, dynamic> fromjson) {
    return Post(
        userId: fromjson["userId"],
        id: fromjson["id"],
        title: fromjson["title"],
        body: fromjson["body"]);
  }
  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
    };
  }
