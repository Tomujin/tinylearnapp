import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'createcontent_event.dart';
part 'createcontent_state.dart';

class CreatecontentBloc extends Bloc<CreatecontentEvent, CreatecontentState> {
  CreatecontentBloc() : super(CreatecontentInitial());

  @override
  Stream<CreatecontentState> mapEventToState(
    CreatecontentEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
