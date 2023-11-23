part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeLodingState extends HomeState {}

class HomeErrorState extends HomeState {
  final AppException exception;

  const HomeErrorState({required this.exception});

  @override
  List<Object> get props => [exception];
}

class HomeSuccesState extends HomeState {
  final List<PostEntity> post;

  const HomeSuccesState(this.post);

  @override
  List<Object> get props => [post];
}
