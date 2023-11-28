part of 'reply_list_bloc.dart';

abstract class ReplyListState extends Equatable {
  const ReplyListState();
  
  @override
  List<Object> get props => [];
}

 class ReplyListInitial extends ReplyListState {}



class ReplyListSuccesState extends ReplyListState {
    final int totallike;
 
  final int totareplise;
  int trueLikeUser;
  final List<LikeId> likeid;

  ReplyListSuccesState(
    this.totallike,
    this.totareplise,
   
    this.trueLikeUser,
    this.likeid,
  );

  @override
  List<Object> get props => [totallike, totareplise,trueLikeUser,likeid];
}


class ReplyListErrorState extends ReplyListState {
  final AppException exception;

  const ReplyListErrorState({required this.exception});

  @override
  List<Object> get props => [exception];
}
