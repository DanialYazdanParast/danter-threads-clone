part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileStartedEvent extends ProfileEvent {
  final String user;

  const ProfileStartedEvent({required this.user});
}

class ProfileRefreshEvent extends ProfileEvent {
  final String user;
  const ProfileRefreshEvent({required this.user});
}

class ProfiledeletPostEvent extends ProfileEvent {
  final String user;
  final String postid;

  const ProfiledeletPostEvent({required this.user, required this.postid});
}
///----------------------------
class AddLikeProfileEvent extends ProfileEvent {
   final String postId;
  final String user;
  AddLikeProfileEvent(
      {required this.postId, required this.user,});
}

class RemoveLikeProfileEvent extends ProfileEvent {
   final String postId;
  final String user;

  RemoveLikeProfileEvent(
      {required this.postId,
      required this.user,
      });
}
//-------------------------


class AddLikeReplyToProfileEvent extends ProfileEvent {
   final String postId;
  final String user;
  AddLikeReplyToProfileEvent(
      {required this.postId, required this.user, });
}

class RemoveLikeReplyToProfileEvent extends ProfileEvent {
   final String postId;
  final String user;

  RemoveLikeReplyToProfileEvent(
      {required this.postId,
      required this.user,
     });
}

//-------------------------


class AddLikeMyReplyProfileEvent extends ProfileEvent {
  final String postId;
  final String user;

  AddLikeMyReplyProfileEvent(
      {required this.postId, required this.user, });
}

class RemoveLikeMyReplyProfileEvent extends ProfileEvent {
   final String postId;
  final String user;


  RemoveLikeMyReplyProfileEvent(
      {required this.postId,
      required this.user,
       });
}

