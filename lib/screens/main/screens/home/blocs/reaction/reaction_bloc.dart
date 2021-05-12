import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:tiny/resources/post-repository.dart';

part 'reaction_event.dart';
part 'reaction_state.dart';

class ReactionBloc extends Bloc<ReactionEvent, ReactionState> {
  final PostRepository postsRepository;

  ReactionBloc({@required this.postsRepository}) : super(ReactionInitial());

  @override
  Stream<ReactionState> mapEventToState(
    ReactionEvent event,
  ) async* {
    if (event is ReactionSaved) {
      yield* _mapPostReactionSave(event);
    }
    if (event is ReactionUnSaved) {
      yield* _mapPostReactionUnSave(event);
    }
  }

  Stream<ReactionState> _mapPostReactionSave(ReactionSaved event) async* {
    try {
      await this
          .postsRepository
          .postReactionSaved(event.userId, event.postId, event.reactionTypes);
      yield ReactionSuccess();
    } catch (_) {
      yield ReactionFailed();
    }
  }

  Stream<ReactionState> _mapPostReactionUnSave(ReactionUnSaved event) async* {
    try {
      await this.postsRepository.deletePostReaction(event.id);
      yield ReactionSuccess();
    } catch (_) {
      yield ReactionFailed();
    }
  }
}
