import 'package:flutter/material.dart';
import 'package:fastfeed/Classes/auth.dart';
import 'package:fastfeed/Classes/post.dart';
import 'package:fastfeed/Enum/appOptions.dart';
import 'package:english_words/english_words.dart';

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
  final wordPair = WordPair.random();

  @override
  Widget build(BuildContext context) {
    final posts = Post();
    return Column(
        children: <Widget>[
          FutureBuilder<dynamic>(
              future: welcomeText,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListTile(title:(snapshot.data.containsKey("message"))
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
