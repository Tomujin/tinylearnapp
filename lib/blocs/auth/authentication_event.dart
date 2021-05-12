part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppLoaded extends AuthenticationEvent {}

class UserLoggedIn extends AuthenticationEvent {
  final User user;
  final Tokens tokens;

  UserLoggedIn({@required this.user, @required this.tokens});

  @override
  List<Object> get props => [user, tokens];
}

class UserLoggedOut extends AuthenticationEvent {}
