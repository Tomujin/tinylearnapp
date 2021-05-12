part of 'activity_bloc.dart';

abstract class ActivityState extends Equatable {
  const ActivityState();

  @override
  List<Object> get props => [];
}

class ActivityInitial extends ActivityState {}

class ActivityLoadedState extends ActivityState {
  final List<User> users;

  ActivityLoadedState(this.users);
  @override
  List<Object> get props => [users];
}

class AcceptUserState extends ActivityState {}
