part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

class CommentInitial extends CommentState {}

class CommentSaving extends CommentState {}

class CommentSaveSuccess extends CommentState {}

class CommentSaveFailure extends CommentState {}
