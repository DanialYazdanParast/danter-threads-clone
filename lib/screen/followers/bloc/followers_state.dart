part of 'followers_bloc.dart';

abstract class FollowersState {
  const FollowersState();
  

}

class FollowersLodingState extends FollowersState {}

class FollowersErrorState extends FollowersState {
  final AppException exception;

  const FollowersErrorState({required this.exception});

}

class FollowersSuccesState extends FollowersState {
  final List<Followers> userFollowers;
  final List<Following> userFollowing;

  const FollowersSuccesState(this.userFollowers, this.userFollowing);

}
