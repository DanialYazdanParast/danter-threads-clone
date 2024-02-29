part of 'chat_bloc.dart';

abstract class ChatState {
  const ChatState();
}

final class ChatLoding extends ChatState {}

class ChatResponseState extends ChatState {
  final List<MessagesList> response;
  final bool online;

  ChatResponseState(this.response, this.online);
}
