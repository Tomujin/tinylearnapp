import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tiny/models/tokens.dart';
import 'package:tiny/screens/switch/switch-screen.dart';
import 'package:tiny/services/oauth2client.dart';
import 'package:tiny/services/secure-storage.dart';

String uuidFromObject(Object object) {
  if (object is Map<String, Object>) {
    final String typeName = object['__typename'] as String;
    final String id = object['id'].toString();
    if (typeName != null && id != null) {
      return <String>[typeName, id].join('/');
    }
  }
  return null;
}

final OptimisticCache cache = OptimisticCache(
  dataIdFromObject: uuidFromObject,
);

Future<T> whenFirst<T>(Stream<T> source) async {
  try {
    await for (T value in source) {
      if (value != null) {
        return value;
      }
    }
  } catch (e) {
    return Future.error(e);
  }
}

Future<FetchResult> refreshToken(
    StreamController<FetchResult> controller,
    NextLink forward,
    Operation operation,
    SecureStorage secureStorage,
    OAuth2Client oAuth2Client,
    GlobalKey<NavigatorState> navigatorKey) async {
  try {
    var mainStream = forward(operation);
    var firstEvent = await whenFirst(mainStream);
    if (firstEvent.errors != null && firstEvent.errors.length > 0) {
      for (var i = 0; i < firstEvent.errors.length; i++) {
        final element = firstEvent.errors[i];
        if (element['extensions']['code'] == "UNAUTHENTICATED") {
          print("#Refreshing tokens");
          final refreshToken = Tokens.fromDictionary(
                  jsonDecode(await secureStorage.getSecureStore("tokens")))
              .refreshToken;
          try {
            final result = await oAuth2Client.refreshTokens(refreshToken);
            var tokensMap = result;
            tokensMap["refresh_token"] = refreshToken;
            final tokens = Tokens.fromDictionary(tokensMap);
            secureStorage.setSecureStore(
                "tokens", jsonEncode(tokens.toDictionary()));
            print("#refreshing access");
            operation.setContext(<String, Map<String, String>>{
              'headers': {"Authorization": "Bearer ${tokens.accessToken}"}
            });
            final againResult = whenFirst(forward(operation));
            return againResult;
          } catch (e) {
            print(e);
            await secureStorage.deleteSecureStore("tokens");
            if (navigatorKey.currentState != null)
              navigatorKey.currentState.push(MaterialPageRoute(builder: (ctx) {
                return SwitchScreen();
              }));
            return whenFirst(forward(operation));
          }
        }
      }
    }
    return firstEvent;
  } catch (e) {
    print(e);
    await secureStorage.deleteSecureStore("tokens");
    if (navigatorKey.currentState != null)
      navigatorKey.currentState.push(MaterialPageRoute(builder: (ctx) {
        return SwitchScreen();
      }));
    return Future.error(e);
  }
}

class CustomAuthLink extends Link {
  CustomAuthLink(GlobalKey<NavigatorState> navigatorKey)
      : super(
          request: (Operation operation, [NextLink forward]) {
            OAuth2Client oAuth2Client = new OAuth2Client();
            SecureStorage secureStorage = new SecureStorage();
            StreamController<FetchResult> controller;
            Future<void> onListen() async {
              final accessToken = Tokens.fromDictionary(
                      jsonDecode(await secureStorage.getSecureStore("tokens")))
                  .accessToken;
              // print("aaaaa $accessToken");
              operation.setContext(<String, Map<String, String>>{
                'headers': {"Authorization": "Bearer $accessToken"}
              });
              final fetchResult = refreshToken(controller, forward, operation,
                      secureStorage, oAuth2Client, navigatorKey)
                  .asStream();
              await controller.addStream(fetchResult);
              await controller.close();
            }

            controller =
                StreamController<FetchResult>.broadcast(onListen: onListen);
            return controller.stream;
          },
        );
}

ValueNotifier<GraphQLClient> clientFor(
    {@required String uri, GlobalKey<NavigatorState> navigatorKey}) {
  HttpLink httpLink = HttpLink(uri: uri);
  final authLink = CustomAuthLink(navigatorKey);
  Link link = authLink.concat(httpLink);

  if (uri != null) {
    final WebSocketLink websocketLink = WebSocketLink(
      url: uri,
      config: SocketClientConfig(
        autoReconnect: true,
        inactivityTimeout: Duration(seconds: 30),
      ),
    );
    link = link.concat(websocketLink);
  }

  return ValueNotifier<GraphQLClient>(
    GraphQLClient(
      cache: cache,
      link: link,
    ),
  );
}
