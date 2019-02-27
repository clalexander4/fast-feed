import 'package:flutter/material.dart';
import 'package:fastfeed/Classes/auth.dart';
import 'package:fastfeed/Classes/post.dart';
import 'package:fastfeed/Enum/appOptions.dart';
import 'package:english_words/english_words.dart';
import 'package:fastfeed/Pages/feed.dart';
import 'package:fastfeed/Classes/oauth.dart';

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

  void showMessage(String text) {
    var alert = new AlertDialog(content: new Text(text), actions: <Widget>[
      new FlatButton(
          child: const Text("Ok"),
          onPressed: () {
            Navigator.pop(context);
          })
    ]);
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  @override
  Widget build(BuildContext context) {
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
                      () async {
                        try {
                          var user = await redditApi.authenticate();
                          showMessage("${user.userData} logged in");
                        } catch (e) {
                          showMessage("error");
                        }
                      }();
                    }
                    break;
                }
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<AppOptions>>[
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
        body: Feed(welcomeText:welcomeText));
  }
}
