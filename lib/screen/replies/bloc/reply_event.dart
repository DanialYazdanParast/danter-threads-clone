part of 'reply_bloc.dart';

sealed class ReplyEvent extends Equatable {
  const ReplyEvent();

  @override
  List<Object> get props => [];
}


class ReplyStartedEvent extends ReplyEvent {
  final String postI;

 const ReplyStartedEvent({required this.postI});
}

class ReplyRefreshEvent extends ReplyEvent {
  final String postI;
 const ReplyRefreshEvent({required this.postI});
}
