part of 'priming_bloc.dart';

abstract class PrimingState extends Equatable {
  const PrimingState();
  
  @override
  List<Object> get props => [];
}

class PrimingInitial extends PrimingState {}
