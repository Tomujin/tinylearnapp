import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:tiny/models/models.dart';
import 'package:tiny/models/userCurriculum.dart';
import 'package:tiny/resources/selectGoal-repository.dart';

part 'selectGoal_event.dart';
part 'selectGoal_state.dart';

class SelectGoalBloc extends Bloc<SelectGoalEvent, SelectGoalState> {
  final SelectGoalRepository selectGoalRepository;

  SelectGoalBloc({@required this.selectGoalRepository})
      : super(SelectGoalInitial());
  @override
  Stream<SelectGoalState> mapEventToState(
    SelectGoalEvent event,
  ) async* {
    if (event is SelectCurriculumEvent) {
      yield* _mapCurriculumClick(event.curriculumId, event.userId);
    }
    if (event is SelectGoalLoaded) {
      yield* _mapSelectGoalInitial(event.parentId, event.userId);
    }
    if (event is SelectGoalSaved) {
      yield* _mapSelectGoalSaved();
    }
  }

  Stream<SelectGoalState> _mapSelectGoalInitial(
      String parentId, String userId) async* {
    Map<dynamic, dynamic> list =
        await this.selectGoalRepository.getCurriculums(parentId, userId);
    yield SelectGoalSuccess(
        curriculums: list["curriculums"],
        userCurriculums: list["userCurriculums"]);
  }

  Stream<SelectGoalState> _mapCurriculumClick(
      String pcurriculumId, String pUserId) async* {
    if (state is SelectGoalSuccess) {
      List<UserCurriculum> userCurriculums = [];
      if ((state as SelectGoalSuccess).userCurriculums != null)
        userCurriculums = (state as SelectGoalSuccess).userCurriculums;

      if (userCurriculums
              .where((field) => field.curriculumId == pcurriculumId)
              .toList()
              .length ==
          0)
        userCurriculums.add(
            new UserCurriculum(curriculumId: pcurriculumId, userId: pUserId));
      else {
        userCurriculums
            .removeWhere((item) => item.curriculumId == pcurriculumId);
      }
      yield SelectGoalStateChanging();
      yield SelectGoalSuccess(
          userCurriculums: userCurriculums,
          curriculums: (state as SelectGoalSuccess).curriculums);
    }
  }

  Stream<SelectGoalState> _mapSelectGoalSaved() async* {
    String isSaved = '';
    if (state is SelectGoalSuccess) {
      isSaved = await this
          .selectGoalRepository
          .saveUserCurriculum((state as SelectGoalSuccess).userCurriculums);
      yield (state as SelectGoalSuccess).copyWith(status: isSaved);
    }
  }
}
