part of 'reply_bloc.dart';

sealed class ReplyEvent {
  const ReplyEvent();

}

class ReplyStartedEvent extends ReplyEvent {
  final String postId;
 
  const ReplyStartedEvent({required this.postId,});
}

class ReplyRefreshEvent extends ReplyEvent {
  final String postId;

  const ReplyRefreshEvent({required this.postId,});
}

//-------------------------------------------------

class AddLikePostEvent extends ReplyEvent {
   final String postId;
  final String user;
   AddLikePostEvent( {required this.postId, required this.user,});
}

class RemoveLikePostEvent extends ReplyEvent {
   final String postId;
  final String user;
   RemoveLikePostEvent( {required this.postId, required this.user,});

}

//-------------------------------------------------
class AddLikeRplyEvent extends ReplyEvent {
   final String postId;
  final String user;
   AddLikeRplyEvent( {required this.postId, required this.user,});

}

class RemoveLikeRplyEvent extends ReplyEvent {
  final String postId;
  final String user;
   RemoveLikeRplyEvent({required this.postId, required this.user,});

}
