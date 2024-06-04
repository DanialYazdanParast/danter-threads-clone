part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();
  @override
  List<Object?> get props => [];
}

class ChatLoding extends ChatState {
  @override
  List<Object?> get props => [];
}

class ChatResponseState extends ChatState {
  final List<MessagesList> response;
  final bool online;

  const ChatResponseState(this.response, this.online);
  @override
  List<Object?> get props => [response, online];
}
