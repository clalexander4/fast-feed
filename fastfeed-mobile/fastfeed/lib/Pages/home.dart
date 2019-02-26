import 'package:flutter/material.dart';
import 'package:fastfeed/Classes/auth.dart';
import 'package:fastfeed/Classes/post.dart';
import 'package:fastfeed/Enum/appOptions.dart';
import 'package:english_words/english_words.dart';
import 'package:fastfeed/Pages/feed.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.welcomeText}) : super(key: key);

  final String title;
  final Future<dynamic> welcomeText;

  @override
  _MyHomePageState createState() => _MyHomePageState(welcomeText: welcomeText);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState({Key key, this.welcomeText});
  final Future<dynamic> welcomeText;
  final wordPair = WordPair.random();

  @override
  Widget build(BuildContext context) {
    final posts = Post();
    return Scaffold(
      appBar: AppBar(
        title: const Text('FastFeed'),
        actions: <Widget>[
          // menu
          PopupMenuButton<AppOptions>(
            onSelected: (AppOptions option) {
              switch (option) {
                case AppOptions.signOut:
                  {
                    authService.signOut();
                  }
                  break;
                case AppOptions.redditAuth:
                  {
                    final String url = "https://www.facebook.com/v2.8/dialog/oauth?client_id={app-id}&redirect_uri=http://localhost:8080/";
                    // UrlLauncher.launch(url);
                  }
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<AppOptions>>[
                  const PopupMenuItem<AppOptions>(
                    value: AppOptions.signOut,
                    child: Text('Sign Out'),
                  ),
                  const PopupMenuItem<AppOptions>(
                    value: AppOptions.redditAuth,
                    child: Text('Authorize Reddit'),
                  ),
                ],
          ),
        ],
      ),
      body: Feed()
    );
  }
}
