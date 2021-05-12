import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:tiny/models/models.dart';
import 'package:tiny/resources/post-repository.dart';
import 'package:tiny/blocs/auth/authentication_bloc.dart';
import 'package:tiny/resources/story-repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final AuthenticationBloc authenticationBloc;
  StreamSubscription authSubscription;
  final PostRepository postsRepository;
  // final StoryRepository storiesRepository;

  PostBloc({
    @required this.postsRepository,
    this.authenticationBloc,
    // this.storiesRepository
  }) : super(const PostState()) {
    void onAuthStateChanged(state) {
      if (state is AuthenticationAuthenticated) {
        add(PostFetched(state.user.id));
      }
    }

    onAuthStateChanged(authenticationBloc.state);
    authSubscription = authenticationBloc.listen(onAuthStateChanged);
  }

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    if (event is PostFetched) {
      yield await _mapPostLoadedToSate(state, event.userId);
    }
  }

  @override
  void onTransition(Transition<PostEvent, PostState> transition) {
    super.onTransition(transition);
  }

  Future<PostState> _mapPostLoadedToSate(PostState state, String userId) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == PostStatus.initial) {
        final posts = await this.postsRepository.getPosts(userId, null);
        return state.copyWith(
          status: PostStatus.success,
          posts: posts,
          hasReachedMax: _hasReachedMax(posts.length),
        );
      }

      final posts = await this
          .postsRepository
          .getPosts(userId, state.posts[state.posts.length - 1].id);
      return posts.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: PostStatus.success,
              posts: List.of(state.posts)..addAll(posts),
              hasReachedMax: _hasReachedMax(posts.length),
            );
    } on Exception {
      return state.copyWith(status: PostStatus.failure);
    }
  }

  bool _hasReachedMax(int postsCount) => postsCount < 6 ? false : true;
  @override
  Future<void> close() {
    authSubscription.cancel();
    return super.close();
  }
}
