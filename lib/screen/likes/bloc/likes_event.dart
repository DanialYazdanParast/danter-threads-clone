part of 'likes_bloc.dart';

abstract class LikesEvent {
  const LikesEvent();
}

class LikesStartedEvent extends LikesEvent {
  final String postId;

  const LikesStartedEvent({required this.postId});
}

//---------------------------------------------------
class LikedAddfollowhEvent extends LikesEvent {
  final String myuserId;
  final String userIdProfile;

  const LikedAddfollowhEvent({
    required this.myuserId,
    required this.userIdProfile,
  });
}

class LikedDelletfollowhEvent extends LikesEvent {
  final String myuserId;
  final String userIdProfile;

  const LikedDelletfollowhEvent({
    required this.myuserId,
    required this.userIdProfile,
  });
}

class LikesRefreshEvent extends LikesEvent {
  final String postId;

  const LikesRefreshEvent({required this.postId});
}
