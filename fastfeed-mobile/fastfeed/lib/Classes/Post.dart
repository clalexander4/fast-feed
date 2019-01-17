import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Post> fetchPost(String url) async {
  final response = await http.get(url);

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    return Post.fromJson(json.decode('{"body": "' + response.body + '"}'));
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class Post {
  final String body;

  Post({this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      body: json['body'],
    );
  }
}