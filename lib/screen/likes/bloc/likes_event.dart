part of 'likes_bloc.dart';

abstract class LikesEvent extends Equatable {
  const LikesEvent();

  @override
  List<Object> get props => [];
}

class LikesStartedEvent extends LikesEvent {
  final String postId;

  const LikesStartedEvent({required this.postId});
}

