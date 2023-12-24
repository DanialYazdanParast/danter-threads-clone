part of 'reply_bloc.dart';

abstract class ReplyState  {
  const ReplyState();

}

class ReplyLodingState extends ReplyState {}


class ReplyErrorState extends ReplyState {
  final AppException exception;
  const ReplyErrorState({required this.exception});
}

class ReplySuccesState extends ReplyState {
  final List<PostEntity> post;
  final List<PostEntity> reply;
  ReplySuccesState(this.post, this.reply,);
}
