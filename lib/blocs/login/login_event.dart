part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class AuthCodeReceived extends LoginEvent {
  final String code;
  AuthCodeReceived({@required this.code});

  @override
  List<dynamic> get props => [code];
}

class GoogleLoginStarted extends LoginEvent {}

class FacebookLoginStarted extends LoginEvent {}

class TomujinDigitalLoginStarted extends LoginEvent {}

class LoginWithEmailPassword extends LoginEvent {
  final String email;
  final String password;
  final AnimationController controller;

  LoginWithEmailPassword(
      {@required this.email,
      @required this.password,
      @required this.controller});

  @override
  List<dynamic> get props => [email, password, controller];
}

class SignUpWithMobile extends LoginEvent {
  final String email;
  final String password;
  final String phoneNumber;
  final AnimationController controller;
  SignUpWithMobile(
      {@required this.email,
      @required this.password,
      @required this.phoneNumber,
      @required this.controller});

  @override
  List<dynamic> get props => [email, password, controller];
}
