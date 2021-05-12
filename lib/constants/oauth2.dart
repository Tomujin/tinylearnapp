class OAuth2Config {
  String authorizeUrl = "http://account.tomujin.digital/oauth2/authorize";
  String registerUrl = "http://account.tomujin.digital/oauth2/register";
  String tokenUrl = "http://account.tomujin.digital/oauth2/token";
  String userInfoEndpoint = "http://account.tomujin.digital/oauth2/userinfo";
  String loginRedirectUri = "tinyapp://login";
  String logoutRedirectUri = "tinyapp://logout";
  String clientId = "0d33a87d-1b95-409b-b628-148d44293674";
  String secret = "ckiobeqr40000ofdyl4cl2ydw";
  List<String> _scopes = ["openid", "email", "profile", "update:profile"];
  String get scopes {
    return this._scopes.join(" ");
  }

  OAuth2Config();
}
