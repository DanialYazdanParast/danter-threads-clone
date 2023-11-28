part of 'reply_list_bloc.dart';

abstract class ReplyListEvent extends Equatable {
  const ReplyListEvent();

  @override
  List<Object> get props => [];
}






class ReplyListStartedEvent extends ReplyListEvent {
  final String postId;
  final String user;
  ReplyListStartedEvent({required this.postId ,required this.user});

  // @override
  // List<Object> get props => [postId,user];
}


class AddLikeReplyListEvent extends ReplyListEvent {
  final String postId;
  final String user;
  AddLikeReplyListEvent({required this.postId ,required this.user});

  @override
  List<Object> get props => [postId,user];
}

class RemoveLikeReplyListEvent extends ReplyListEvent {
  final String postId;
  final String user;
   final String likeId;

  RemoveLikeReplyListEvent( {required this.postId ,required this.user ,required this.likeId,});

  @override
  List<Object> get props => [postId,user];
}
