import 'package:flutter/material.dart';
import 'package:fastfeed/Classes/auth.dart';
import 'package:fastfeed/Enum/appOptions.dart';
import 'package:fastfeed/Pages/feed.dart';
import 'package:fastfeed/Pages/connections.dart';

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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('FastFeed'),
          actions: <Widget>[
            // menu
            PopupMenuButton<AppOption>(
              onSelected: (AppOption option) {
                switch (option) {
                  case AppOption.signOut:
                    {
                      authService.signOut();
                    }
                    break;
                  case AppOption.openConnections:
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Connections())
                      );
                    }
                    break;
                }
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<AppOption>>[
                    const PopupMenuItem<AppOption>(
                      value: AppOption.signOut,
                      child: Text('Sign Out'),
                    ),
                    const PopupMenuItem<AppOption>(
                      value: AppOption.openConnections,
                      child: Text('Manage connections'),
                    ),
                  ],
            ),
          ],
        ),
        body: Feed(
          welcomeText: welcomeText,
        ));
  }
}
