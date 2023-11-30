part of 'followers_bloc.dart';

abstract class FollowersState extends Equatable {
  const FollowersState();
  
  @override
  List<Object> get props => [];
}

class FollowersLodingState extends FollowersState {}

class FollowersErrorState extends FollowersState {
  final AppException exception;

  const FollowersErrorState({required this.exception});

  @override
  List<Object> get props => [exception];
}

class FollowersSuccesState extends FollowersState {
  final List<Followers> userFollowers;
  final List<Following> userFollowing;

  const FollowersSuccesState(this.userFollowers, this.userFollowing);

  @override
  List<Object> get props => [userFollowers ,userFollowing];
}
