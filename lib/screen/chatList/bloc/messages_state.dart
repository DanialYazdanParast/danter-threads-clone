part of 'messages_bloc.dart';

sealed class MessagesState {
  const MessagesState();
}

final class MessagesLoding extends MessagesState {}

class MessagesResponseState extends MessagesState {
  final List<MessagesList> response;

  MessagesResponseState(this.response);
}
