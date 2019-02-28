import 'package:flutter/material.dart';
import 'package:fastfeed/Classes/post.dart';

class PostListState extends State<PostList> {
  PostListState({Key key, this.postList});
  Future<List<Post>> postList;
  final Set<Post> _saved = new Set<Post>();
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _smallerFont = const TextStyle(fontSize: 12.0);

  @override
  Widget build(BuildContext context) {
    return _buildPostList();
  }

  Widget _buildPostList() {
    Future<void> refreshPosts() async {
      setState(() {
        postList = getPosts();
      });
    }
    return RefreshIndicator(
        onRefresh: refreshPosts,
        child: FutureBuilder<dynamic>(
          future: postList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  padding: const EdgeInsets.all(16.0),
                  itemBuilder: (context, index) {
                    return _buildRow(snapshot.data[index]);
                  });
            } else {
              return Column(children: <Widget>[CircularProgressIndicator()]);
            }
          },
        ));
  }

  Widget _buildRow(Post post) {
    final bool alreadySaved = _saved.contains(post);
    return Card(
        child: Column(children: <Widget>[
      new ListTile(
        leading: Icon(Icons.person),
        title: new Text(
          post.title,
          style: _biggerFont,
        ),
        subtitle: new Text(
          post.message,
          style: _smallerFont,
        ),
        trailing: new Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null,
        ),
        onTap: () {
          setState(() {
            if (alreadySaved) {
              _saved.remove(post);
            } else {
              _saved.add(post);
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

class PostList extends StatefulWidget {
  PostList({Key key, this.postList}) : super(key: key);

  final Future<List<Post>> postList;

  @override
  PostListState createState() => new PostListState(postList: postList);
}
