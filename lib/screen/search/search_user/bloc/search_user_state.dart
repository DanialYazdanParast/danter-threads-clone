part of 'search_user_bloc.dart';

abstract class SearchUserState {
  const SearchUserState();
}

class SearchUserInitial extends SearchUserState {}

class SearchUserLodingState extends SearchUserState {}

class SearchUserSuccesState extends SearchUserState {
  final List<User> user;
  const SearchUserSuccesState(this.user);
}

class SearchUserErrorState extends SearchUserState {
  final AppException exception;
  const SearchUserErrorState({required this.exception});
}

class SearchUserHiveSuccesState extends SearchUserState {
  final List<User> user;
  const SearchUserHiveSuccesState(this.user);
}
