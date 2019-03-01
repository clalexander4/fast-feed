import 'dart:async';

import 'package:simple_auth/simple_auth.dart';
import "package:http/http.dart" as http;

class PinterestApi extends OAuthApi {
  PinterestApi(String identifier, String clientId, String clientSecret,
      String redirectUrl, bool isIos,
      {List<String> scopes,
      http.Client client,
      Converter converter,
      AuthStorage authStorage,
      String state})
      : super.fromIdAndSecret(identifier, clientId, clientSecret,
            client: client,
            scopes: scopes,
            converter: converter,
            authStorage: authStorage) {
    this.scopesRequired = true;
    this.tokenUrl = "https://api.pinterest.com/v1/oauth/token";
    this.baseUrl = "https://api.pinterest.com";
    this.authorizationUrl = "https://api.pinterest.com/oauth/";
    this.redirectUrl = redirectUrl;
    this.state = state;
    this.isIos = isIos;
  }

  String state;
  bool isIos = false;

  @override
  Authenticator getAuthenticator() {
    var authenticator = PinterestAuthenticator(identifier, clientId,
      clientSecret, tokenUrl, authorizationUrl, redirectUrl, scopes, state);
    authenticator.useEmbeddedBrowser = !isIos;
    return authenticator;
  }

  @override
  Future<OAuthAccount> getAccountFromAuthCode(
      WebAuthenticator authenticator) async {
    var auth = authenticator as PinterestAuthenticator;
    return OAuthAccount(identifier,
        created: DateTime.now().toUtc(),
        expiresIn: -1,
        scope: authenticator.scope,
        refreshToken: auth.token,
        tokenType: auth.tokenType,
        token: auth.token);
  }
}

class PinterestAuthenticator extends OAuthAuthenticator {
  Uri redirectUri;
  String state;
  PinterestAuthenticator(String identifier, String clientId, String clientSecret,
      String tokenUrl, String baseUrl, String redirectUrl, List<String> scopes, String state)
      : super(identifier, clientId, clientSecret, tokenUrl, baseUrl,
            redirectUrl) {
    authCodeKey = "code";
    redirectUri = Uri.parse(redirectUrl);
    state = state;
  }
  String token;
  String tokenType;
  String uid;

  bool checkUrl(Uri url) {
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
      "client_id": clientId,
      "response_type": "code",
      "redirect_uri": redirectUrl,
      "duration": "permanent",
      "state": "anything",
      "scope": "read_public,write_public,read_relationships,write_relationships"
    };

    return data;
  }

}