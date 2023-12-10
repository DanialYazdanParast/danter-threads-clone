part of 'write_reply_bloc.dart';

sealed class WriteReplyEvent extends Equatable {
  const WriteReplyEvent();

  @override
  List<Object> get props => [];
}

class WriteReplySendPostEvent extends WriteReplyEvent {
  final String user;
  final String text;
  final String postid;
  final image;
  const WriteReplySendPostEvent({
    required this.user,
    required this.text,
    required this.postid,
    required this.image,
  });
}
