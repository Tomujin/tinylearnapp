part of 'selectGoal_bloc.dart';

abstract class SelectGoalEvent extends Equatable {
  const SelectGoalEvent();

  @override
  List<Object> get props => [];
}

class SelectGoalLoaded extends SelectGoalEvent {
  final String parentId;
  final String userId;
  SelectGoalLoaded(this.parentId, this.userId);
  @override
  List<Object> get props => [parentId, userId];

  @override
  String toString() => 'Loaded { parentId: $parentId,userId: $userId }';
}

class SelectCurriculumEvent extends SelectGoalEvent {
  final String curriculumId;
  final String userId;
  SelectCurriculumEvent(this.curriculumId, this.userId);

  @override
  List<Object> get props => [curriculumId, this.userId];

  @override
  String toString() => 'Loaded { curriculumId: $curriculumId userId: $userId }';
}

class SelectGoalSaved extends SelectGoalEvent {}
