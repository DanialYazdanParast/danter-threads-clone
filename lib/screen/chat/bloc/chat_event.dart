part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ChatInitilzeEvent extends ChatEvent {
  final String myuserid;
  final String useridchat;
  const ChatInitilzeEvent({required this.myuserid, required this.useridchat});
  @override
  List<Object?> get props => [useridchat];
}

class ChatSuccesEvent extends ChatEvent {
  const ChatSuccesEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ChatSuccesonlineEvent extends ChatEvent {}

class SendChatEvent extends ChatEvent {
  final String usersend;
  final String userseen;
  final String text;
  final String roomid;
  const SendChatEvent({
    required this.usersend,
    required this.userseen,
    required this.text,
    required this.roomid,
  });
}
