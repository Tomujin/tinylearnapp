part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class CommentAdded extends CommentEvent {
  final String userId;
  final String postId;
  final String comment;

  const CommentAdded({this.userId, this.postId, this.comment});

  @override
  List<Object> get props => [userId, postId, comment];

  @override
  String toString() => 'CommentSaved { comment: $userId,$postId,$comment }';
}
