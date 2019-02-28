import 'package:flutter/material.dart';
import 'package:fastfeed/Pages/login.dart';
import 'package:fastfeed/Pages/home.dart';
import 'package:fastfeed/Classes/functions.dart';
import 'package:fastfeed/Classes/auth.dart';
import 'dart:io';
import 'package:simple_auth/simple_auth.dart' as simpleAuth;
import 'package:simple_auth_flutter/simple_auth_flutter.dart';

void main() {
  runApp(MyApp());
  // HttpServer 
  //   .bind(InternetAddress.loopbackIPv6, 8090)
  //   .then((server) {server.listen((HttpRequest request) {
  //     request.response
  //       ..statusCode = 200
  //       ..headers.set("Content-Type", ContentType.html.mimeType)
  //       ..write("<html><h1>You can now close this window</h1></html>");
  //       request.response.close();
  //   });
  // });
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SimpleAuthFlutter.init(context);
    return MaterialApp(
      title: 'FastFeed',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: StreamBuilder(
          stream: authService.user,
          builder: (context, snapshot) => (snapshot.hasData)
              ? MyHomePage(
                  title: 'FastFeed',
                  welcomeText: callFunction('helloWorld',
                      <String, dynamic>{"name": snapshot.data.email}),
                )
              : LoginSignUpPage()),
    );
  }
}
