import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tiny/models/user.dart';
import 'package:tiny/resources/user-repository.dart';

part 'activity_event.dart';
part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final UserRepository _userRepo;
  ActivityBloc(UserRepository userRepo)
      : assert(userRepo != null),
        _userRepo = userRepo,
        super(ActivityInitial());
  // ActivityBloc() : super(ActivityInitial());

  @override
  Stream<ActivityState> mapEventToState(
    ActivityEvent event,
  ) async* {
    if (event is ActivityLoadEvent) {
      yield* _mapActiveLoadToState();
    }
    if (event is UserAcceptEvent) {
      yield* _mapUserAcceptToState(event.userId, event.acceptUserId);
    }
  }

  Stream<ActivityLoadedState> _mapActiveLoadToState() async* {
    final users = await this._userRepo.getUnacceptedUsers();
    yield ActivityLoadedState(users);
  }

  Stream<AcceptUserState> _mapUserAcceptToState(userId, acceptUserId) async* {
    final success = await this._userRepo.acceptUser(userId, acceptUserId);

    yield AcceptUserState();
  }
}
