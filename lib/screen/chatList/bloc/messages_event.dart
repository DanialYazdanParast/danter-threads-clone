part of 'messages_bloc.dart';

sealed class MessagesEvent {
  const MessagesEvent();
}

class MessagesInitilzeEvent extends MessagesEvent {
  final String userId;

  MessagesInitilzeEvent({required this.userId});
}

class MessagesSuccesEvent extends MessagesEvent {}

class MessagesSelectionEvent extends MessagesEvent {
  final User user;

  MessagesSelectionEvent({required this.user});
}
