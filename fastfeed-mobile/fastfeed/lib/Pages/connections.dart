import 'package:flutter/material.dart';
import 'package:fastfeed/Classes/oauth.dart';
import 'package:simple_auth/simple_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fastfeed/Classes/auth.dart';
import 'package:fastfeed/Classes/functions.dart';
import 'package:fastfeed/Widgets/message.dart';

class Connections extends StatefulWidget {
  Connections({Key key, this.title, this.welcomeText}) : super(key: key);

  final String title;
  final Future<dynamic> welcomeText;

  @override
  _ConnectionsState createState() =>
      _ConnectionsState(welcomeText: welcomeText);
}

class _ConnectionsState extends State<Connections> {
  _ConnectionsState({Key key, this.welcomeText});
  final Future<dynamic> welcomeText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Manage Connections")),
        body: Center(
            child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () async {
                try {
                  await redditApi.logOut();
                  OAuthAccount user = await redditApi.authenticate();
                  FirebaseUser currentUser = await authService.getCurrentUser();
                  callFunction("saveToken",
                      {"token": user.token, "uid": currentUser.uid});
                  showMessage("Logged into Reddit!", context);
                } catch (e) {
                  showMessage(
                      "Couldn't log into Reddit successfully :(", context);
                }
              },
              child: const Text('Authorize Reddit'),
              color: Colors.deepOrange,
              textColor: Colors.white,
            )
          ],
        )));
  }
}
