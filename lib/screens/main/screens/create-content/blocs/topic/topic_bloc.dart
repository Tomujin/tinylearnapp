import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'topic_event.dart';
part 'topic_state.dart';

class TopicBloc extends Bloc<TopicEvent, TopicState> {
  TopicBloc() : super(TopicInitial());

  @override
  Stream<TopicState> mapEventToState(
    TopicEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
