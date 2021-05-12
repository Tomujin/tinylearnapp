import 'dart:convert';

import 'package:tiny/models/tokens.dart';
import 'package:tiny/services/oauth2client.dart';
import 'package:tiny/services/secure-storage.dart';

enum UserProvider { Google, Facebook, TomujinDigital }

class UserClaims {
  final String sub;
  final String email;
  final String firstName;
  final UserProvider provider;
  final String lastName;
  final String picture;
  final String gender;
  final DateTime birthday;
  UserClaims(
      {this.sub,
      this.email,
      this.firstName,
      this.lastName,
      this.provider,
      this.picture,
      this.gender,
      this.birthday});
}

class AuthencationRepository {
  final OAuth2Client _oAuth2Client = new OAuth2Client();
  final SecureStorage _secureStorage = new SecureStorage();

  // String get authorizationUrl {
  //   return this._oAuth2Client.authorizationUrl;
  // }

  String get registrationUrl {
    return this._oAuth2Client.registrationUrl;
  }

  Future<Tokens> authenticateWithCode(String authCode) async {
    final tokensJson = await _oAuth2Client.getTokens(authCode);
    final tokens = Tokens.fromDictionary(tokensJson);
    await this.persistToken(tokens);
    return tokens;
  }

  Future<bool> hasTokens() async {
    try {
      final token = await this.getTokens();
      return token != null;
    } catch (e) {
      return false;
    }
  }

  Future<Tokens> getTokens() async {
    final tokens = await _secureStorage.getSecureStore("tokens");
    return tokens != null ? Tokens.fromDictionary(jsonDecode(tokens)) : null;
  }

  Future<void> updateAccessToken(String accessToken) async {
    final tokens = await this.getTokens();
    tokens.accessToken = accessToken;
    await this.persistToken(tokens);
  }

  Future<void> persistToken(Tokens tokens) async {
    _secureStorage.setSecureStore("tokens", jsonEncode(tokens.toDictionary()));
  }

  Future<void> deleteTokens() async {
    _secureStorage.deleteSecureStore("tokens");
  }

  Future<dynamic> getUserInfo() async {
    final tokens = await this.getTokens();
    final userInfoJSON = await _oAuth2Client.getUserInfo(tokens.accessToken);
    return userInfoJSON['data'];
  }

  Future<dynamic> signInWithPassword({String email, String password}) async {
    final oAuth2Client = OAuth2Client();
    final tokensJson =
        await oAuth2Client.loginWithPassword(email: email, password: password);
    final tokens = Tokens.fromDictionary(tokensJson);
    await this.persistToken(tokens);
    return tokens;
  }

  Future<dynamic> signUpWithEmail({String email, String password}) async {
    final oAuth2Client = OAuth2Client();
    final responesJson =
        await oAuth2Client.signupWithMobile(email: email, password: password);
    return true;
  }
}
