part of 'profile_user_bloc.dart';

sealed class ProfileUserEvent extends Equatable {
  const ProfileUserEvent();

  @override
  List<Object> get props => [];
}

class ProfileUserStartedEvent extends ProfileUserEvent {
 final String user;
 const ProfileUserStartedEvent({required this.user});
}

class ProfileUserRefreshEvent extends ProfileUserEvent {
 final String user;
 const ProfileUserRefreshEvent({required this.user});
}
