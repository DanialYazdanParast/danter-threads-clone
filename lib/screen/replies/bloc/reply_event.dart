part of 'reply_bloc.dart';

sealed class ReplyEvent extends Equatable {
  const ReplyEvent();

  @override
  List<Object> get props => [];
}

class ReplyStartedEvent extends ReplyEvent {
  final String postId;
  final String user;
  const ReplyStartedEvent({required this.postId,required this.user});
}

class ReplyRefreshEvent extends ReplyEvent {
  final String postId;
  final String user;
  const ReplyRefreshEvent({required this.postId,required this.user});
}

class AddLikeReplyEvent extends ReplyEvent {
  final String postId;
  final String user;
  AddLikeReplyEvent({required this.postId, required this.user});

  @override
  List<Object> get props => [postId, user];
}

class RemoveLikeReplyEvent extends ReplyEvent {
  final String postId;
  final String user;
  final String likeId;

  RemoveLikeReplyEvent({
    required this.postId,
    required this.user,
    required this.likeId,
  });

  @override
  List<Object> get props => [postId, user];
}
