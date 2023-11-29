part of 'profile_user_bloc.dart';

abstract class ProfileUserState  {
  const ProfileUserState();
  
}

class ProfileUserLodingState extends ProfileUserState {}

class ProfileUserErrorState extends ProfileUserState {
  final AppException exception;

  const ProfileUserErrorState({required this.exception});


}

class ProfileUserSuccesState extends ProfileUserState {
  final List<PostEntity> post;
    final int totalfollowers;
    int truefollowing;
    final List<FollowId> followId;

   ProfileUserSuccesState(this.post, this.totalfollowers ,this.truefollowing, this.followId);

}
