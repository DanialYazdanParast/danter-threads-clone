part of 'profile_user_bloc.dart';

sealed class ProfileUserState extends Equatable {
  const ProfileUserState();
  
  @override
  List<Object> get props => [];
}

class ProfileUserLodingState extends ProfileUserState {}

class ProfileUserErrorState extends ProfileUserState {
  final AppException exception;

  const ProfileUserErrorState({required this.exception});

  @override
  List<Object> get props => [exception];
}

class ProfileUserSuccesState extends ProfileUserState {
  final List<PostEntity> post;
    final int totalfollowers;

  const ProfileUserSuccesState(this.post, this.totalfollowers);

  @override
  List<Object> get props => [post];
}
