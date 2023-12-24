part of 'likes_bloc.dart';

sealed class LikesState  {
  const LikesState();
  
 
}

class LikesLodingState extends LikesState {}

class LikesErrorState extends LikesState {
  final AppException exception;

  const LikesErrorState({required this.exception});

}

class LikesSuccesState extends LikesState {
  final List<LikeUser> user;

   LikesSuccesState(this.user,);

}




