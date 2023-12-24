part of 'profile_bloc.dart';

abstract class ProfileState  {
  const ProfileState();
  

}

class ProfileLodingState extends ProfileState {}

class ProfileErrorState extends ProfileState {
  final AppException exception;

  const ProfileErrorState({required this.exception});

}

class ProfileSuccesState extends ProfileState {
  final List<PostEntity> post;

   final List<Followers> userFollowers;
    final List<PostReply> reply;

  const ProfileSuccesState(this.post, this.userFollowers ,this.reply);


}

