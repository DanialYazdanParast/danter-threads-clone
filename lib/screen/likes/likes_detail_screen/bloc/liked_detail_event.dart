part of 'liked_detail_bloc.dart';

abstract class LikedDetailEvent   {
  const LikedDetailEvent();

}

class LikedDetailStartedEvent extends LikedDetailEvent {
  final String myuserId;
  final String userIdProfile;

  const LikedDetailStartedEvent(
      {required this.myuserId,
      required this.userIdProfile,
     });
}


class LikedDetailRefreshEvent extends LikedDetailEvent {
  final String myuserId;
  final String userIdProfile;

  const LikedDetailRefreshEvent(
      {required this.myuserId,
      required this.userIdProfile,
     });
}





class LikedDetailAddfollowhEvent extends LikedDetailEvent {
  final String myuserId;
  final String userIdProfile;
  
  const LikedDetailAddfollowhEvent({
    required this.myuserId,
    required this.userIdProfile,
   
  });
}

class LikedDetailDelletfollowhEvent extends LikedDetailEvent {
  final String myuserId;
  final String userIdProfile;
  final String followId;
  const LikedDetailDelletfollowhEvent(
      {required this.myuserId,
      required this.userIdProfile,
      required this.followId});
}
