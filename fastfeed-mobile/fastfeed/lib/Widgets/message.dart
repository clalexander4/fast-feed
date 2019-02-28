import 'package:flutter/material.dart';

void showMessage(String text, BuildContext context) {
  var alert = new AlertDialog(content: new Text(text), actions: <Widget>[
    new FlatButton(
        child: const Text("Ok"),
        onPressed: () {
          Navigator.pop(context);
        })
  ]);
  showDialog(context: context, builder: (BuildContext context) => alert);
}
