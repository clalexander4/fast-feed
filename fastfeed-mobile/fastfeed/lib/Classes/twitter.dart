import 'dart:async';

import 'package:simple_auth/simple_auth.dart';
import "package:http/http.dart" as http;

class TwitterApi extends OAuthApi 
{
  /*  Paramaters Explained
  *   - consumer_key = Twitter supplied ID for FastFeed
  *   - consumer_secret = PROBABLY WONT USE
  *   - redirectUrl = paramater for POST oauth/request_token
  */
  TwitterApi(String identifier, String consumer_key, String cunsumer_secret, String redirectUrl,
      {List<String> scopes,
      http.Client client,
      Converter converter,
      AuthStorage authStorage})
      : super.fromIdAndSecret(identifier, consumer_key, cunsumer_secret,
            client: client,
            scopes: scopes,
            converter: converter,
            authStorage: authStorage) 
    {
    this.scopesRequired = true;
    this.tokenUrl = "https://api.twitter.com/oauth/request_token";
    this.baseUrl = "https://api.twitter.com";
    this.authorizationUrl = "https://api.twitter.com/oauth/authorize";
    this.redirectUrl = redirectUrl;
    }
  String consumer_key;
  String cunsumer_secret;
  
  Authenticator getAuthenticator() => TwitterAuthenticator(identifier, consumer_key,
  cunsumer_secret, tokenUrl, authorizationUrl, redirectUrl, scopes);


  @override
  Future<OAuthAccount> getAccountFromAuthCode(
      WebAuthenticator authenticator) async {
    var auth = authenticator as TwitterAuthenticator;
    return OAuthAccount(identifier,
        created: DateTime.now().toUtc(),
        expiresIn: -1,
        scope: authenticator.scope,
        refreshToken: auth.token,
        tokenType: auth.tokenType,
        token: auth.token);
  }
}

class TwitterAuthenticator extends OAuthAuthenticator
{
  Uri redirectUri;

  TwitterAuthenticator(String identifier, String consumer_key, String consumer_secret, String tokenUrl,
      String baseUrl, String redirectUrl, List <String> scopes)
      : super(identifier, consumer_key, consumer_secret, tokenUrl, baseUrl,
            redirectUrl) {
    authCodeKey = "code";
    redirectUri = Uri.parse(redirectUrl);
  }
  String token;
  String tokenType;
  String uid;
  String consumer_key;
  String consumer_secret;

  bool checkUrl(Uri url) 
  {
    try {
      if (url.hasFragment && !url.hasQuery) {
        url = url.replace(query: url.fragment);
      }

      if (url?.host != redirectUri.host) return false;
      if (url?.query?.isEmpty ?? true) return false;
      if (!url.queryParameters.containsKey(authCodeKey)) return false;
      var code = url.queryParameters[authCodeKey];
      if (code?.isEmpty ?? true) return false;
      token = code;
      tokenType = url.queryParameters["token_type"] == 'bearer'
          ? 'Bearer'
          : url.queryParameters["token_type"];
      uid = url.queryParameters["uid"];
      foundAuthCode(code);
      return true;
    } catch (exception) {
      print(exception);
      return false;
    }
  }

  @override
  Future<Map<String, dynamic>> getInitialUrlQueryParameters() async {
    var data = {
      "consumer_key": consumer_key,
      "response_type": "code",
      "callbackUri": redirectUrl,
      "duration": "permanent",
      "scope": "read"
    };

    return data;
  }
}