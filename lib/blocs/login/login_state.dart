part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({@required this.error});

  @override
  List<Object> get props => [error];
}

class LoginWithSignup extends LoginState {
  final UserClaims userClaims;

  LoginWithSignup({@required this.userClaims});

  @override
  List<dynamic> get props => [userClaims];
}

class SignUpSuccess extends LoginState {}
