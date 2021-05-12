part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoadState extends ProfileState {
  final User user;

  ProfileLoadState(this.user);

  @override
  List<Object> get props => [user];
}

class ProfileLoading extends ProfileState {}

class ProfileSaveState extends ProfileState {}

class ProfileChangeRoleClickState extends ProfileState {}

class ProfileChangeRoleClickedState extends ProfileState {}
