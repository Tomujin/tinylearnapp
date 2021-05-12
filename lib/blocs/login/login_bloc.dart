import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tiny/blocs/auth/authentication_bloc.dart';
import 'package:tiny/models/tokens.dart';
import 'package:tiny/models/user.dart';
import 'package:tiny/resources/authentication-repository.dart';
import 'package:tiny/resources/user-repository.dart';
import 'package:tiny/services/secure-storage.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationBloc _authBloc;
  final AuthencationRepository _authRepo;
  final UserRepository _userRepo;
  final SecureStorage _secureStorage = new SecureStorage();
  LoginBloc(
      {AuthenticationBloc authBloc,
      AuthencationRepository authRepo,
      UserRepository userRepo})
      : assert(authBloc != null),
        assert(authRepo != null),
        assert(userRepo != null),
        this._authBloc = authBloc,
        this._authRepo = authRepo,
        this._userRepo = userRepo,
        super(LoginInitial());

  @override
  void onTransition(Transition<LoginEvent, LoginState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    // if (event is GoogleLoginStarted) {
    //   yield* _mapGoogleLoginStartedToState();
    // }
    // if (event is FacebookLoginStarted) {
    //   yield* _mapFacebookLoginStartedToState();
    // }
    // if (event is TomujinDigitalLoginStarted) {
    //   yield* _mapTomujinDigitalLoginStartedToState();
    // }
    if (event is LoginWithEmailPassword) {
      yield* _mapLoginWithEmailPasswordToState(event);
    }
    if (event is SignUpWithMobile) {
      yield* _mapSignUpWithMobile(event);
    }
  }

  // Stream<LoginState> _mapGoogleLoginStartedToState() async* {
  //   yield LoginLoading();
  //   try {
  //     final googleUserClaims = await _authRepo.signInWithGoogle();
  //     print(googleUserClaims.sub);
  //     print(await _userRepo.checkIfUserExists(googleUserClaims.sub));
  //     if (!(await _userRepo.checkIfUserExists(googleUserClaims.sub))) {
  //       yield LoginWithSignup(userClaims: googleUserClaims);
  //     }
  //   } catch (e) {
  //     yield LoginFailure(error: e.toString());
  //   }
  // }

  // Stream<LoginState> _mapFacebookLoginStartedToState() async* {
  //   yield LoginLoading();
  //   try {
  //     await _authRepo.signInWithFacebook();
  //   } catch (e) {
  //     yield LoginFailure(error: e.toString());
  //   }
  // }

  // Stream<LoginState> _mapTomujinDigitalLoginStartedToState() async* {
  //   yield LoginLoading();
  //   try {
  //     await _authRepo.signInWithTomujinDigital();
  //   } catch (e) {
  //     yield LoginFailure(error: e.toString());
  //   }
  // }
  Stream<LoginState> _mapSignUpWithMobile(SignUpWithMobile event) async* {
//  event.controller.forward();
    yield LoginLoading();
    try {
      final response = await _authRepo.signUpWithEmail(
          email: event.email, password: event.password);

      if (response) yield SignUpSuccess();
      // event.controller.reverse();
    } catch (e) {
      // event.controller.reverse();
      yield LoginFailure(error: e.toString());
    }
  }

  Stream<LoginState> _mapLoginWithEmailPasswordToState(
      LoginWithEmailPassword event) async* {
    event.controller.forward();
    yield LoginLoading();
    try {
      Tokens tokens = await _authRepo.signInWithPassword(
          email: event.email, password: event.password);
      User user = await this._userRepo.getMe();
      if (user == null && await this._authRepo.hasTokens()) {
        yield LoginWithSignup();
      }
      if (user != null) {
        this._authBloc.add(UserLoggedIn(user: user, tokens: tokens));
        _secureStorage.setSecureStore("userId", user.id);
        yield LoginSuccess();
      } else {
        yield LoginFailure(error: 'Something very weird just happened');
      }
      event.controller.reverse();
    } catch (e) {
      event.controller.reverse();
      yield LoginFailure(error: e.toString());
    }
  }
}
