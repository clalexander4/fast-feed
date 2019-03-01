import 'package:fastfeed/Classes/reddit.dart' as reddit;
import 'package:flutter/material.dart';

var redditApi = (context) => new reddit.RedditApi("reddit", "8huDE0vSDV4wKg", "", "com.fastr.fastfeed://redirect", Theme.of(context).platform == TargetPlatform.iOS, scopes: ["identity","edit","flair","history","mysubreddits","read","save","submit","vote"], state: "whatever");
