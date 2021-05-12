part of 'reaction_bloc.dart';

abstract class ReactionEvent extends Equatable {
  const ReactionEvent();

  @override
  List<Object> get props => [];
}

class ReactionSaved extends ReactionEvent {
  final String userId;
  final String postId;
  final int reactionTypes;

  const ReactionSaved({this.userId, this.postId, this.reactionTypes});

  @override
  List<Object> get props => [userId, postId, reactionTypes];

  @override
  String toString() =>
      'CommentSaved { comment: $userId,$postId,$reactionTypes }';
}

class ReactionUnSaved extends ReactionEvent {
  final String id;

  const ReactionUnSaved({
    this.id,
  });

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'CommentSaved { comment: $id }';
}
