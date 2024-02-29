part of 'chat_bloc.dart';

abstract class ChatEvent {
  const ChatEvent();
}

class ChatInitilzeEvent extends ChatEvent {
  final String myuserid;
  final String useridchat;
  ChatInitilzeEvent({required this.myuserid, required this.useridchat});
}

class ChatSuccesEvent extends ChatEvent {}

class ChatSuccesonlineEvent extends ChatEvent {}

class SendChatEvent extends ChatEvent {
  final String usersend;
  final String userseen;
  final String text;
  final String roomid;
  SendChatEvent({
    required this.usersend,
    required this.userseen,
    required this.text,
    required this.roomid,
  });
}
