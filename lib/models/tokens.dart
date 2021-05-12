class Tokens {
  String accessToken;
  String refreshToken;
  String idToken;
  Tokens({this.accessToken, this.refreshToken, this.idToken});
  factory Tokens.fromDictionary(Map<String, dynamic> json) {
    return Tokens(
        accessToken: json['access_token'],
        refreshToken: json['refresh_token'],
        idToken: json['id_token']);
  }
  Map<String, dynamic> toDictionary() {
    return {
      "access_token": this.accessToken,
      "refresh_token": this.refreshToken,
      "id_token": this.idToken
    };
  }
}
