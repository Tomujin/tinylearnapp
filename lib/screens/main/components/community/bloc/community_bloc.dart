import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tiny/models/user.dart';
import 'package:tiny/resources/user-repository.dart';

part 'community_event.dart';
part 'community_state.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  UserRepository userRepo;
  CommunityBloc(this.userRepo) : super(CommunityInitial());

  @override
  Stream<CommunityState> mapEventToState(
    CommunityEvent event,
  ) async* {
    if (event is MemberLoadEvent) {
      yield* _mapMemberLoadToState();
    }
  }

  Stream<CommunityState> _mapMemberLoadToState() async* {
    List<User> users;
    yield MemberLoadingState();
    users = await this.userRepo.getUsers();
    yield MemberLoadedState(users: users);
  }
}
