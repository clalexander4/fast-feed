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
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<dynamic>(
                future: welcomeText,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text((snapshot.data.containsKey("message"))
                        ? snapshot.data["message"]
                        : "Hello!");
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  return CircularProgressIndicator();
                }),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
              future: welcomeText,
                return CircularProgressIndicator();
              }),
          new Expanded(child: posts),
        ],
      ),
    );
  }
}
