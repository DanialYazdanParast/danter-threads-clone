part of 'chat_desktop_bloc.dart';

abstract class ChatDesktopEvent {
  const ChatDesktopEvent();
}

class ChatDesktopSelectionEvent extends ChatDesktopEvent {
  final User user;

  const ChatDesktopSelectionEvent({required this.user});
}
