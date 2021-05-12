import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tiny/models/user.dart';
import 'package:tiny/resources/user-repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepo;
  ProfileBloc(UserRepository userRepo)
      : assert(userRepo != null),
        _userRepo = userRepo,
        super(ProfileInitial());

  @override
  void onTransition(Transition<ProfileEvent, ProfileState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is LoadProfileEvent) {
      yield* _mapprofileScreenOpenToState();
    }
    if (event is ChangeRoleClickEvent) {
      yield* _mapChangeRole(false);
    }
    if (event is ChangeRoleClickedEvent) {
      yield* _mapChangeRole(true);
    }
    if (event is ProfileSaveEvent) {
      yield* _mapProfileSave(event.user);
    }
  }

  Stream<ProfileState> _mapprofileScreenOpenToState() async* {
    final user = await this._userRepo.getMe();

    yield ProfileLoadState(user);
  }

  Stream<ProfileSaveState> _mapProfileSave(User user) async* {
    final save = await this
        ._userRepo
        .putUser(user.id, user.firstName, user.lastName, user.bio);
    print(user.profilePic);
    yield ProfileSaveState();
  }

  Stream<ProfileState> _mapChangeRole(bool learner) async* {
    if (learner)
      yield ProfileChangeRoleClickState();
    else
      yield ProfileChangeRoleClickedState();
  }
}
