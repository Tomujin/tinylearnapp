part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent extends Equatable {
  // const ProfileEvent();

  @override
  List<Object> get props => [];
}

class LoadProfileEvent extends ProfileEvent {}

class ProfileSaveEvent extends ProfileEvent {
  final User user;
  ProfileSaveEvent(this.user);
}

class ChangeRoleClickEvent extends ProfileEvent {}

class ChangeRoleClickedEvent extends ProfileEvent {}
