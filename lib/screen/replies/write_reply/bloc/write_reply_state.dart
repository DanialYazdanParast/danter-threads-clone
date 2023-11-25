part of 'write_reply_bloc.dart';

sealed class WriteReplyState extends Equatable {
  const WriteReplyState();
  
  @override
  List<Object> get props => [];
}

 class WriteReplyInitial extends WriteReplyState {}





class WriteReplyLodingState extends WriteReplyState {}

class WriteReplyErrorState extends WriteReplyState {
  final AppException exception;

  const WriteReplyErrorState({required this.exception});

  @override
  List<Object> get props => [exception];
}

class WriteReplySuccesState extends WriteReplyState {

}