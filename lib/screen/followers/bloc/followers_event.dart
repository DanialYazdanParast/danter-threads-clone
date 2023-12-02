part of 'followers_bloc.dart';

 class FollowersEvent  {
  const FollowersEvent();

}


class FollowersStartedEvent extends FollowersEvent {
  final String user;
 const FollowersStartedEvent({required this.user});

}


class FollowersRefreshEvent extends FollowersEvent {
  final String user;
 const FollowersRefreshEvent({required this.user});

}