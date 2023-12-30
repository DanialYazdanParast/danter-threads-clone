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
    List<Followers> userFollowers;
    final List<PostReply> reply;
    final User user;

   ProfileUserSuccesState(this.post, this.userFollowers ,this.reply, this.user);

}
