part of 'home_bloc.dart';

abstract class HomeState  {
  const HomeState();

}

class HomeLodingState extends HomeState {}

class HomeErrorState extends HomeState {
  final AppException exception;

  const HomeErrorState({required this.exception});

}

class HomeSuccesState extends HomeState {
   List<PostEntity> post;

   HomeSuccesState(this.post);

}
