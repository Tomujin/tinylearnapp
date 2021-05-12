part of 'selectGoal_bloc.dart';

abstract class SelectGoalState extends Equatable {
  const SelectGoalState();

  @override
  List<Object> get props => [];
}

class SelectGoalInitial extends SelectGoalState {}

class SelectGoalSuccess extends SelectGoalState {
  final List<UserCurriculum> userCurriculums;
  final schools;
  final List<Curriculum> curriculums;
  final String status;

  SelectGoalSuccess(
      {this.userCurriculums, this.schools, this.curriculums, this.status});

  @override
  List<Object> get props => [userCurriculums, curriculums, status];

  SelectGoalSuccess copyWith(
      {List<Object> userCurriculum,
      List<Curriculum> curriculums,
      String status}) {
    if (userCurriculum != null || curriculums != null)
      return SelectGoalSuccess(
          userCurriculums: userCurriculum ?? this.userCurriculums,
          curriculums: curriculums ?? this.curriculums,
          status: 'Modified');

    return SelectGoalSuccess(
        userCurriculums: userCurriculum ?? this.userCurriculums,
        curriculums: curriculums ?? this.curriculums,
        status: status ?? this.status);
  }

  @override
  String toString() =>
      'SelectGoalSuccess { userCurriculums: $userCurriculums, schools: $schools, curriculums: $curriculums, status: $status }';
}

class SelectGoalStateChanging extends SelectGoalState {}
