part of 'followers_page_bloc.dart';

abstract class FollowersPageState {
  const FollowersPageState();
}

class FollowersPageInitial extends FollowersPageState {}

class FollowersPageSuccesState extends FollowersPageState {
  int truefollowing;
  final List<FollowId> followId;
  FollowersPageSuccesState(this.truefollowing, this.followId);
}

class FollowersPageErrorState extends FollowersPageState {
  final AppException exception;

  const FollowersPageErrorState({required this.exception});
}
