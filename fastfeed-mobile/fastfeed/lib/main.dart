import 'package:flutter/material.dart';
import 'package:fastfeed/Pages/login.dart';
import 'package:fastfeed/Pages/home.dart';
import 'package:fastfeed/Classes/functions.dart';
import 'package:fastfeed/Classes/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
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
