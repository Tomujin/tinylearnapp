part of 'reaction_bloc.dart';

abstract class ReactionState extends Equatable {
  const ReactionState();

  @override
  List<Object> get props => [];
}

class ReactionInitial extends ReactionState {}

class ReactionSuccess extends ReactionState {}

class ReactionFailed extends ReactionState {}
