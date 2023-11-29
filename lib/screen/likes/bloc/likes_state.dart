part of 'likes_bloc.dart';

sealed class LikesState extends Equatable {
  const LikesState();
  
  @override
  List<Object> get props => [];
}


class LikesLodingState extends LikesState {}

class LikesErrorState extends LikesState {
  final AppException exception;

  const LikesErrorState({required this.exception});

  @override
  List<Object> get props => [exception];
}

class LikesSuccesState extends LikesState {
  final List<LikeUser> user;

   LikesSuccesState(this.user,);

  @override
  List<Object> get props => [user];
}




