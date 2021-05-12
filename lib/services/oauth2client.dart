import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tiny/constants/oauth2.dart';

class OAuth2Client {
  String _grantType = "code";
  OAuth2Config _oauth2Config = new OAuth2Config();
  Dio _dio = new Dio();

  String get authorizationUrl {
    return Uri.encodeFull(this._oauth2Config.authorizeUrl +
        "?client_id=${this._oauth2Config.clientId}" +
        "&scope=${this._oauth2Config.scopes}" +
        "&redirect_uri=${this._oauth2Config.loginRedirectUri}" +
        "&response_type=${this._grantType}");
  }

  String get registrationUrl {
    return Uri.encodeFull(this._oauth2Config.registerUrl +
        "?client_id=${this._oauth2Config.clientId}" +
        "&redirect_uri=${this._oauth2Config.logoutRedirectUri}" +
        "&scope=${this._oauth2Config.scopes}" +
        "&response_type=${this._grantType}");
  }

  Future<dynamic> getTokens(String code) async {
    final basicAuth = base64.encode(utf8
        .encode("${this._oauth2Config.clientId}:${this._oauth2Config.secret}"));
    final response = await this._dio.post(this._oauth2Config.tokenUrl,
        data: {
          "grant_type": 'authorization_code',
          "code": code,
          "redirect_uri": this._oauth2Config.loginRedirectUri,
        },
        options: Options(headers: {"Authorization": "Basic $basicAuth"}));
    return response.data;
  }

  Future<dynamic> getUserInfo(String accessToken) async {
    final response = await this._dio.get(this._oauth2Config.userInfoEndpoint,
        options: Options(headers: {"Authorization": "Bearer $accessToken"}));
    return response.data;
  }

  Future<dynamic> refreshTokens(String refreshToken) async {
    final basicAuth = base64.encode(utf8
        .encode("${this._oauth2Config.clientId}:${this._oauth2Config.secret}"));
    final response = await this._dio.post(this._oauth2Config.tokenUrl,
        data: {
          "grant_type": 'refresh_token',
          "refresh_token": refreshToken,
        },
        options: Options(headers: {"Authorization": "Basic $basicAuth"}));
    return response.data;
  }

  Future<dynamic> loginWithPassword({String email, String password}) async {
    final basicAuth = base64.encode(utf8
        .encode("${this._oauth2Config.clientId}:${this._oauth2Config.secret}"));
    final response = await this._dio.post(this._oauth2Config.tokenUrl,
        data: {
          "grant_type": 'password',
          "username": email.trim(),
          "password": password,
          "scope": this._oauth2Config.scopes
        },
        options: Options(headers: {"Authorization": "Basic $basicAuth"}));
    print(response);
    return response.data;
  }

  Future<dynamic> signupWithMobile(
      {String email, String password, String mobile}) async {
    final basicAuth = base64.encode(utf8
        .encode("${this._oauth2Config.clientId}:${this._oauth2Config.secret}"));
    final response = await this._dio.post(this._oauth2Config.registerUrl,
        data: {
          "grant_type": 'password',
          "email": email.trim(),
          "fullname": email.trim(),
          "password": password,
          "scope": this._oauth2Config.scopes
        },
        options: Options(headers: {'X-Requested-With': 'XMLHttpRequest'}));
    return response.data;
  }
}
