part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class PostStartedEvent extends PostEvent {
  final String postId;

  PostStartedEvent({required this.postId});

  @override
  List<Object> get props => [postId];
}
