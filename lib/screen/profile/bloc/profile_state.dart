part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  
  @override
  List<Object> get props => [];
}

class ProfileLodingState extends ProfileState {}

class ProfileErrorState extends ProfileState {
  final AppException exception;

  const ProfileErrorState({required this.exception});

  @override
  List<Object> get props => [exception];
}

class ProfileSuccesState extends ProfileState {
  final List<PostEntity> post;

  const ProfileSuccesState(this.post);

  @override
  List<Object> get props => [post];
}

