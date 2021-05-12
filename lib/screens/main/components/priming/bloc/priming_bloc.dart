import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'priming_event.dart';
part 'priming_state.dart';

class PrimingBloc extends Bloc<PrimingEvent, PrimingState> {
  PrimingBloc() : super(PrimingInitial());

  @override
  Stream<PrimingState> mapEventToState(
    PrimingEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
