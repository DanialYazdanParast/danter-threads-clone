part of 'reply_bloc.dart';

abstract class ReplyState extends Equatable {
  const ReplyState();

  @override
  List<Object> get props => [];
}

class ReplyLodingState extends ReplyState {}

class ReplyErrorState extends ReplyState {
  final AppException exception;

  const ReplyErrorState({required this.exception});

  @override
  List<Object> get props => [exception];
}

class ReplySuccesState extends ReplyState {
  final List<PostEntity> post;
  final int totallike;

  final int totareplise;
  int trueLikeUser;
  final List<LikeId> likeid;

  ReplySuccesState(this.post, this.totallike, 
      this.totareplise, this.likeid, this.trueLikeUser);

  @override
  List<Object> get props =>
      [post, totallike, totareplise, trueLikeUser, likeid];
}
