part of 'reply_list_bloc.dart';

abstract class ReplyListEvent extends Equatable {
  const ReplyListEvent();

  @override
  List<Object> get props => [];
}


class ReplyListStartedEvent extends ReplyListEvent {
  final String replyId;

  ReplyListStartedEvent({required this.replyId});

  @override
  List<Object> get props => [replyId];
}
