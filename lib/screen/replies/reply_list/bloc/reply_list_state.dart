part of 'reply_list_bloc.dart';

abstract class ReplyListState extends Equatable {
  const ReplyListState();
  
  @override
  List<Object> get props => [];
}

 class ReplyListInitial extends ReplyListState {}



class ReplyListSuccesState extends ReplyListState {
  final int totallike;
// final List<Replyphoto> totareplisePhoto;
  final int totareplise;

  const ReplyListSuccesState(this.totallike, this.totareplise, );

  @override
  List<Object> get props => [totallike,totareplise ];
}

class ReplyListErrorState extends ReplyListState {
  final AppException exception;

  const ReplyListErrorState({required this.exception});

  @override
  List<Object> get props => [exception];
}
