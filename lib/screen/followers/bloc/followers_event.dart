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

//-----------------------------------

class FollowersAddfollowhEvent extends FollowersEvent {
  final String myuserId;
  final String userIdProfile;
  
  const FollowersAddfollowhEvent({
    required this.myuserId,
    required this.userIdProfile,
   
  });
}

class FollowersDelletfollowhEvent extends FollowersEvent {
  final String myuserId;
  final String userIdProfile;

  const FollowersDelletfollowhEvent(
      {required this.myuserId,
      required this.userIdProfile,
     });
}


//--------------------------------------------

class FollowingAddfollowhEvent extends FollowersEvent {
  final String myuserId;
  final String userIdProfile;
  
  const FollowingAddfollowhEvent({
    required this.myuserId,
    required this.userIdProfile,
   
  });
}

class FollowingDelletfollowhEvent extends FollowersEvent {
  final String myuserId;
  final String userIdProfile;

  const FollowingDelletfollowhEvent(
      {required this.myuserId,
      required this.userIdProfile,
     });
}

//--------------------------------


class FollowersRemovefollowhEvent extends FollowersEvent {
  final String myuserId;
  final String userIdProfile;

  const FollowersRemovefollowhEvent(
      {required this.myuserId,
      required this.userIdProfile,
     });
}