part of 'profile_user_bloc.dart';

sealed class ProfileUserEvent extends Equatable {
  const ProfileUserEvent();

  @override
  List<Object> get props => [];
}

class ProfileUserStartedEvent extends ProfileUserEvent {
  final String myuserId;
  final String user;
  const ProfileUserStartedEvent(
   {required this.myuserId,
   required this.user,}
  );
}

class ProfileUserRefreshEvent extends ProfileUserEvent {
   final String myuserId;
  final String user;
  const ProfileUserRefreshEvent({required this.myuserId,required this.user,});
}



class ProfileUserAddfollowhEvent extends ProfileUserEvent {
   final String myuserId;
  final String userIdProfile;
  const ProfileUserAddfollowhEvent({required this.myuserId,required this.userIdProfile,});
}



class ProfileUserDelletfollowhEvent extends ProfileUserEvent {
   final String myuserId;
  final String userIdProfile;

  const ProfileUserDelletfollowhEvent({required this.myuserId,required this.userIdProfile,});
}



///----------------------------
class AddLikeProfileUserEvent extends ProfileUserEvent {
   final String postId;
  final String user;
  AddLikeProfileUserEvent(
      {required this.postId, required this.user,});
}

class RemoveLikeProfileUserEvent extends ProfileUserEvent {
   final String postId;
  final String user;

  RemoveLikeProfileUserEvent(
      {required this.postId,
      required this.user,
      });
}
//-------------------------


class AddLikeReplyToProfileUserEvent extends ProfileUserEvent {
   final String postId;
  final String user;
  AddLikeReplyToProfileUserEvent(
      {required this.postId, required this.user, });
}

class RemoveLikeReplyToProfileUserEvent extends ProfileUserEvent {
   final String postId;
  final String user;

  RemoveLikeReplyToProfileUserEvent(
      {required this.postId,
      required this.user,
     });
}

//-------------------------


class AddLikeMyReplyProfileUserEvent extends ProfileUserEvent {
  final String postId;
  final String user;

  AddLikeMyReplyProfileUserEvent(
      {required this.postId, required this.user, });
}

class RemoveLikeMyReplyProfileUserEvent extends ProfileUserEvent {
   final String postId;
  final String user;


  RemoveLikeMyReplyProfileUserEvent(
      {required this.postId,
      required this.user,
       });
}

