part of 'activity_bloc.dart';

abstract class ActivityEvent extends Equatable {
  const ActivityEvent();
  @override
  List<Object> get props => [];
}

class ActivityLoadEvent extends ActivityEvent {}

class UserAcceptEvent extends ActivityEvent {
  final String userId;
  final String acceptUserId;
  UserAcceptEvent(this.userId, this.acceptUserId);
}
