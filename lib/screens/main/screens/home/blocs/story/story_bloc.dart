import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tiny/models/story.dart';

import 'package:tiny/resources/story-repository.dart';
part 'story_event.dart';
part 'story_state.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  StoryBloc({this.storiesRepository}) : super(StoryState());

  @override
  Stream<StoryState> mapEventToState(
    StoryEvent event,
  ) async* {
    yield await _mapPostFetchedToState(state);
    // TODO: implement mapEventToState
  }

  final StoryRepository storiesRepository;
  Future<StoryState> _mapPostFetchedToState(StoryState state) async {
    try {
      // if (state.status == StoryStatus.initial) {
      final stories = await this.storiesRepository.getStories();
      return state.copyWith(
        status: StoryStatus.success,
        stories: stories,
        hasReachedMax: false,
      );
      // }
      // print("sss ${state.posts[state.posts.length - 1].id}");
      // final posts = await this
      //     .postsRepository
      //     .getPosts("dd", state.posts[state.posts.length - 1].id);
      // return posts.isEmpty
      //     ? state.copyWith(hasReachedMax: true)
      //     : state.copyWith(
      //         status: PostStatus.success,
      //         posts: List.of(state.posts)..addAll(posts),
      //         hasReachedMax: _hasReachedMax(posts.length),
      //       );
    } on Exception {
      return state.copyWith(status: StoryStatus.failure);
    }
  }
}
