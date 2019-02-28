import 'package:fastfeed/Classes/functions.dart';
import 'package:fastfeed/Classes/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Post {
  Post(this.title, this.author, this.message, this.timestamp, this.likes);

  String title;
  String author;
  String message;
  String timestamp;
  int likes;
}

Future<List<Post>> getPosts() async {
  FirebaseUser currentUser = await authService.getCurrentUser();
  Map<String, dynamic> redditSubmissions = await callFunction(
      "getRedditPosts", {"subreddit": "all", "uid": currentUser.uid});
  List<Post> posts = <Post>[];
  if (redditSubmissions.containsKey("submissions")) {
    List<dynamic> submissions = redditSubmissions["submissions"];
    submissions.forEach((submission) => {
          posts.add(new Post(
              submission["title"],
              submission["author"],
              submission["selftext"],
              submission["created_utc"].toString(),
              submission["score"]))
        });
  }
  return posts;
}
