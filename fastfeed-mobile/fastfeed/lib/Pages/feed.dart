import 'package:flutter/material.dart';
import 'package:fastfeed/Widgets/post_list.dart';
import 'package:fastfeed/Classes/post.dart' as Post;

class Feed extends StatefulWidget {
  Feed({Key key, this.title, this.welcomeText}) : super(key: key);

  final String title;
  final Future<dynamic> welcomeText;

  @override
  _FeedState createState() => _FeedState(welcomeText: welcomeText);
}

class _FeedState extends State<Feed> {
  _FeedState({Key key, this.welcomeText});
  final Future<dynamic> welcomeText;

  @override
  Widget build(BuildContext context) {
    final posts = PostList(
      postList: Post.getPosts(),
    );
    return Column(
      children: <Widget>[
        FutureBuilder<dynamic>(
            future: welcomeText,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListTile(
                    title: (snapshot.data.containsKey("message"))
                        ? Text(snapshot.data["message"])
                        : Text("Hello!"));
              } else if (snapshot.hasError) {
                return ListTile(title: Text("${snapshot.error}"));
              }
              return CircularProgressIndicator();
            }),
        new Expanded(child: posts),
      ],
    );
  }
}
