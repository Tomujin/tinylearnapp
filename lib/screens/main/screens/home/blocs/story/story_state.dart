part of 'story_bloc.dart';

enum StoryStatus { initial, success, failure }

class StoryState extends Equatable {
  const StoryState({
    this.status = StoryStatus.initial,
    this.stories = const <Story>[],
    this.hasReachedMax = false,
  });
  final StoryStatus status;
  final List<Story> stories;
  final bool hasReachedMax;
  StoryState copyWith({
    StoryStatus status,
    List<Story> stories,
    bool hasReachedMax,
  }) {
    return StoryState(
      status: status ?? this.status,
      stories: stories ?? this.stories,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, stories, hasReachedMax];
}

class StoryInitial extends StoryState {}
