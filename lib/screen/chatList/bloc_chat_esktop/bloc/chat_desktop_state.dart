part of 'chat_desktop_bloc.dart';

abstract class ChatDesktopState {
  const ChatDesktopState();
}

class ChatDesktopInitial extends ChatDesktopState {}

class ChatDesktopSelectionState extends ChatDesktopState {
  final User user;
  const ChatDesktopSelectionState(
    this.user,
  );
}
