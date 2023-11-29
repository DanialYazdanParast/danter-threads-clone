part of 'liked_detail_bloc.dart';

sealed class LikedDetailState   {
  const LikedDetailState();
  
  
}

final class LikedDetailInitial extends LikedDetailState {}



class LikedDetailSuccesState extends LikedDetailState {
     int truefollowing;
   final List<FollowId> followId;

   LikedDetailSuccesState( this.followId ,this.truefollowing);

}


class LikedDetailErrorState extends LikedDetailState {
  final AppException exception;

  const LikedDetailErrorState({required this.exception});

}
