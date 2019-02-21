import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class PostState extends State<Post> {
  final _suggestions = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _smallerFont = const TextStyle(fontSize: 12.0);

  @override
  Widget build(BuildContext context) {
    return _buildSuggestions();
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return Card(
        child: Column(children: <Widget>[
      new ListTile(
        leading: Icon(Icons.person),
        title: new Text(
          "Sample Post Title",
          style: _biggerFont,
        ),
        subtitle: new Text(
          "This is a really cool post from somewhere among your social media feeds",
          style: _smallerFont,
        ),
        trailing: new Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null,
        ),
        onTap: () {
          setState(() {
            if (alreadySaved) {
              _saved.remove(pair);
            } else {
              _saved.add(pair);
            }
          });
        },
      ),
      ButtonTheme.bar(
        // make buttons use the appropriate styles for cards
        child: ButtonBar(
          children: <Widget>[
            FlatButton(
              child: Icon(Icons.comment),
              onPressed: () {/* ... */},
            ),
            FlatButton(
              child: Icon(Icons.share),
              onPressed: () {/* ... */},
            ),
          ],
        ),
      ),
    ]));
  }
}

class Post extends StatefulWidget {
  @override
  PostState createState() => new PostState();
}
