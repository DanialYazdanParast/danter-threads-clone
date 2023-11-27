part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class PostStartedEvent extends PostEvent {
  final String postId;
  final String user;
  PostStartedEvent({required this.postId ,required this.user});

  // @override
  // List<Object> get props => [postId,user];
}


class AddLikePostEvent extends PostEvent {
  final String postId;
  final String user;
  AddLikePostEvent({required this.postId ,required this.user});

  @override
  List<Object> get props => [postId,user];
}

class RemoveLikePostEvent extends PostEvent {
  final String postId;
  final String user;
   final String likeId;

  RemoveLikePostEvent( {required this.postId ,required this.user ,required this.likeId,});

  @override
  List<Object> get props => [postId,user];
}
