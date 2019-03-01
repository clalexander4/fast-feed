import 'package:fastfeed/Classes/reddit.dart' as reddit;
import 'package:fastfeed/Classes/pinterest.dart' as pinterest;
import 'package:flutter/material.dart';

var redditApi = (context) => new reddit.RedditApi(
    "reddit",
    "8huDE0vSDV4wKg",
    "",
    "com.fastr.fastfeed://redirect",
    Theme.of(context).platform == TargetPlatform.iOS,
    scopes: [
      "identity",
      "edit",
      "flair",
      "history",
      "mysubreddits",
      "read",
      "save",
      "submit",
      "vote"
    ],
    state: "whatever");
var pinterestApi = (context) => new pinterest.PinterestApi("pinterest",
    "5015546618693320013", "clientSecret", "https://localhost", false,
    scopes: [
      "identity",
      "edit",
      "flair",
      "history",
      "mysubreddits",
      "read",
      "save",
      "submit",
      "vote"
    ],
    state: "whatever");
