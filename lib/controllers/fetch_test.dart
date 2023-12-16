import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Posts> fetchPosts(http.Client client) async {
  final response = await client.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
  if (response.statusCode == 200) {
    return Posts.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class Posts {
int userId;
int id;
String title;
String body;
Posts({
required this.userId,
required this.id,
required this.title,
required this.body,
});
factory Posts.fromJson(Map<String, dynamic> json) => Posts(
userId: json["userId"],
id: json["id"],
title: json["title"],
body: json["body"],
);
Map<String, dynamic> toJson() => {
"userId": userId,
"id": id,
"title": title,
"body": body,
};
}