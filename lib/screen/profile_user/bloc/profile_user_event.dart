part of 'profile_user_bloc.dart';

sealed class ProfileUserEvent extends Equatable {
  const ProfileUserEvent();

  @override
  List<Object> get props => [];
}

class ProfileUserStartedEvent extends ProfileUserEvent {
  final String myuserId;
  final String userIdProfile;
  const ProfileUserStartedEvent(
   {required this.myuserId,
   required this.userIdProfile,}
  );
}

class ProfileUserRefreshEvent extends ProfileUserEvent {
   final String myuserId;
  final String userIdProfile;
  const ProfileUserRefreshEvent({required this.myuserId,required this.userIdProfile,});
}



class ProfileUserAddfollowhEvent extends ProfileUserEvent {
   final String myuserId;
  final String userIdProfile;
  const ProfileUserAddfollowhEvent({required this.myuserId,required this.userIdProfile,});
}



class ProfileUserDelletfollowhEvent extends ProfileUserEvent {
   final String myuserId;
  final String userIdProfile;
  final String followId;
  const ProfileUserDelletfollowhEvent({required this.myuserId,required this.userIdProfile,required this.followId});
}
