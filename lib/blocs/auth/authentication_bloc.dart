import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:tiny/models/tokens.dart';
import 'package:tiny/models/user.dart';
import 'package:tiny/resources/authentication-repository.dart';
import 'package:tiny/resources/user-repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthencationRepository _authRepo;
  final UserRepository _userRepo;
  AuthenticationBloc(AuthencationRepository authRepo, UserRepository userRepo)
      : assert(authRepo != null),
        assert(userRepo != null),
        _authRepo = authRepo,
        _userRepo = userRepo,
        super(AuthenticationInitial());

  @override
  void onTransition(
      Transition<AuthenticationEvent, AuthenticationState> transition) {
    super.onTransition(transition);
  }

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    print("Auth bloc $event");
    if (event is AppLoaded) {
      yield* _mapAppLoadedToState();
    }
    if (event is UserLoggedIn) {
      yield* _mapUserLoggedInToState(event);
    }
    if (event is UserLoggedOut) {
      yield* _mapUserLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppLoadedToState() async* {
    final hasTokens = await _authRepo.hasTokens();
    if (hasTokens) {
      try {
        User user = await _userRepo.getMe();
        if (user == null) {
          Tokens tokens = await _authRepo.getTokens();
          user = await _userRepo.signUpMe(tokens.idToken);
        }
        Tokens tokens = await _authRepo.getTokens();
        yield AuthenticationAuthenticated(user: user, tokens: tokens);
      } catch (e) {
        print(e);
      }
    } else {
      yield AuthenticationNotAuthenticated();
    }
  }

  Stream<AuthenticationState> _mapUserLoggedInToState(
      UserLoggedIn event) async* {
    print("work is here fine ");
    yield AuthenticationAuthenticated(user: event.user, tokens: event.tokens);
  }

  Stream<AuthenticationState> _mapUserLoggedOutToState() async* {
    await _authRepo.deleteTokens();
    print("auth bloc log out");
    yield AuthenticationNotAuthenticated();
  }
}
