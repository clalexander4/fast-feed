import 'package:fastfeed/Classes/reddit.dart' as reddit;

var redditApi = new reddit.RedditApi("reddit", "8huDE0vSDV4wKg", "", "http://localhost", scopes: ["identity","edit","flair","history","mysubreddits","read","save","submit","vote"], state: "whatever");
