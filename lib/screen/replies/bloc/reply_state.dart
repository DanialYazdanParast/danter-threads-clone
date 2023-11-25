part of 'reply_bloc.dart';

sealed class ReplyState extends Equatable {
  const ReplyState();
  
  @override
  List<Object> get props => [];
}

class ReplyLodingState extends ReplyState {}

class ReplyErrorState extends ReplyState {
  final AppException exception;

  const ReplyErrorState({required this.exception});

  @override
  List<Object> get props => [exception];
}

class ReplySuccesState extends ReplyState {
  final List<RplyEntity> post;

  const ReplySuccesState(this.post);

  @override
  List<Object> get props => [post];
}
