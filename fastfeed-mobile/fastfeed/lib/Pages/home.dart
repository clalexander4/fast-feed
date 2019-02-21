import 'package:flutter/material.dart';
import 'package:fastfeed/Classes/auth.dart';
import 'package:fastfeed/Classes/post.dart';
import 'package:fastfeed/Enum/appOptions.dart';
import 'package:english_words/english_words.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.welcomeText}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final Future<dynamic> welcomeText;

  @override
  _MyHomePageState createState() => _MyHomePageState(welcomeText: welcomeText);
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState({Key key, this.welcomeText});
  int _counter = 0;
  final Future<dynamic> welcomeText;
  final wordPair = WordPair.random();

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final posts = Post();
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<AppOptions>>[
                  const PopupMenuItem<AppOptions>(
                    value: AppOptions.signOut,
                    child: Text('Sign Out'),
                  ),
                ],
          ),
        ],
      ),
      body:  Column(
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
      ),
    );
  }
}
