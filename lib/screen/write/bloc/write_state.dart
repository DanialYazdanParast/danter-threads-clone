part of 'write_bloc.dart';

abstract class WriteState extends Equatable {
  const WriteState();
  
  @override
  List<Object> get props => [];
}

 class WriteInitial extends WriteState {}



class WriteLodingState extends WriteState {}

class WriteErrorState extends WriteState {
  final AppException exception;

  const WriteErrorState({required this.exception});

  @override
  List<Object> get props => [exception];
}

class WriteSuccesState extends WriteState {

}