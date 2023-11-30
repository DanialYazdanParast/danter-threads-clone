part of 'followers_bloc.dart';

 class FollowersEvent extends Equatable {
  const FollowersEvent();

  @override
  List<Object> get props => [];
}


class FollowersStartedEvent extends FollowersEvent {
  final String user;

 const FollowersStartedEvent({required this.user});

}
