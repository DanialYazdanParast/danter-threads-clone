part of 'search_bloc.dart';

sealed class SearchState {
  const SearchState();
}

class SearchLodingState extends SearchState {}

class SearchErrorState extends SearchState {
  final AppException exception;
  const SearchErrorState({required this.exception});
}

class SearchSuccesState extends SearchState {
  final List<User> user;
  const SearchSuccesState(
    this.user,
  );
}
