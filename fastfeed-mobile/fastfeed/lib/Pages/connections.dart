import 'package:flutter/material.dart';
import 'package:fastfeed/Classes/oauth.dart';
import 'package:simple_auth/simple_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fastfeed/Classes/auth.dart';
import 'package:fastfeed/Classes/functions.dart';
import 'package:fastfeed/Widgets/message.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

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
  bool isRedditAuthorized = false;
  bool isPinterestAuthorized = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Manage Connections")),
        body: Center(
            child: Column(
          children: <Widget>[
            SignInButton(
              Buttons.Reddit,
              onPressed: () async {
                try {
                  if (isRedditAuthorized) {
                    await redditApi(context).logOut();
                    isRedditAuthorized = !isRedditAuthorized;
                  } else {
                    await redditApi(context).loadAccountFromCache();
                    OAuthAccount user = await redditApi(context).authenticate();
                    FirebaseUser currentUser =
                        await authService.getCurrentUser();
                    callFunction("saveToken",
                        {"token": user.token, "uid": currentUser.uid});
                    showMessage("Logged into Reddit!", context);
                  }
                } catch (e) {
                  showMessage("Something went wrong communicating with Reddit",
                      context);
                }
              },
            ),
            SignInButton(
              Buttons.Pinterest,
              onPressed: () async {
                try {
                  if (isPinterestAuthorized) {
                    await pinterestApi(context).logOut();
                    isPinterestAuthorized = !isPinterestAuthorized;
                  } else {
                    await pinterestApi(context).loadAccountFromCache();
                    OAuthAccount user =
                        await pinterestApi(context).authenticate();
                    FirebaseUser currentUser =
                        await authService.getCurrentUser();
                    callFunction("saveToken",
                        {"token": user.token, "uid": currentUser.uid});
                    showMessage("Logged into Pinterest!", context);
                  }
                } catch (e) {
                  showMessage(
                      "Something went wrong communicating with Pinterest",
                      context);
                }
              },
            ),
          ],
        )));
  }
}
