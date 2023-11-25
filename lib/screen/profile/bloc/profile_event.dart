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
