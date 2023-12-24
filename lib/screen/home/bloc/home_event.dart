part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeStartedEvent extends HomeEvent {
  final String user;

  const HomeStartedEvent({required this.user});
}

class HomeRefreshEvent extends HomeEvent {
  final String user;
  const HomeRefreshEvent({required this.user});
}

class AddLikePostEvent extends HomeEvent {
  final String postId;
  final String user;

   AddLikePostEvent( {required this.postId, required this.user, });

}

class RemoveLikePostEvent extends HomeEvent {
  final String postId;
  final String user;


   RemoveLikePostEvent({
    required this.postId,
    required this.user,

  });

}
