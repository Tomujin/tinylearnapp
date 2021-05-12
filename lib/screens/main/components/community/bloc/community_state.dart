part of 'community_bloc.dart';

abstract class CommunityState extends Equatable {
  const CommunityState();

  @override
  List<Object> get props => [];
}

class CommunityInitial extends CommunityState {}

class MemberLoadingState extends CommunityState {}

class MemberLoadingErrorState extends CommunityState {}

class MemberLoadedState extends CommunityState {
  final List<User> users;
  MemberLoadedState({this.users});
}
