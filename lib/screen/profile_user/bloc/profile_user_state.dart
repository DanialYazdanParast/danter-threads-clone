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

  const ProfileUserSuccesState(this.post);

  @override
  List<Object> get props => [post];
}
