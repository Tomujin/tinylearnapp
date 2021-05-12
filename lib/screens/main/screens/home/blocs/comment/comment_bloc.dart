import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:tiny/resources/post-repository.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final PostRepository postsRepository;

  CommentBloc({@required this.postsRepository}) : super(CommentInitial());

  @override
  Stream<CommentState> mapEventToState(
    CommentEvent event,
  ) async* {
    if (event is CommentAdded) {
      yield* _mapPostComentSave(event);
    }
  }

  Stream<CommentState> _mapPostComentSave(CommentAdded event) async* {
    try {
      yield CommentSaving();
      await this.postsRepository.postCommentSaved(
            userId: event.userId,
            postId: event.postId,
            comment: event.comment,
          );
      yield CommentSaveSuccess();
    } catch (_) {
      yield CommentSaveFailure();
    }
  }
}
