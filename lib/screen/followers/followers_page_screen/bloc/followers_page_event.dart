part of 'followers_page_bloc.dart';

abstract class FollowersPageEvent  {
  const FollowersPageEvent();


}

class FollowersPageStartedEvent extends FollowersPageEvent {
  final String myuserId;
  final String userIdProfile;

  const FollowersPageStartedEvent({
    required this.myuserId,
    required this.userIdProfile,
  });
}


class FollowersPageAddfollowhEvent extends FollowersPageEvent {
  final String myuserId;
  final String userIdProfile;
  
  const FollowersPageAddfollowhEvent({
    required this.myuserId,
    required this.userIdProfile,
   
  });
}

class FollowersPageDelletfollowhEvent extends FollowersPageEvent {
  final String myuserId;
  final String userIdProfile;
  final String followId;
  const FollowersPageDelletfollowhEvent(
      {required this.myuserId,
      required this.userIdProfile,
      required this.followId});
}
