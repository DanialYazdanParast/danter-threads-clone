part of 'search_user_bloc.dart';

abstract class SearchUserEvent extends Equatable {
  const SearchUserEvent();

  @override
  List<Object> get props => [];
}

class SearchUserKeyUsernameEvent extends SearchUserEvent {
  final String keyUsername;
  final String userId;

  const SearchUserKeyUsernameEvent(
      {required this.keyUsername, required this.userId});
}

//-----------------------------
class SearchUserAddfollowhEvent extends SearchUserEvent {
  final String myuserId;
  final String userIdProfile;

  const SearchUserAddfollowhEvent({
    required this.myuserId,
    required this.userIdProfile,
  });
}

class SearchUserDelletfollowhEvent extends SearchUserEvent {
  final String myuserId;
  final String userIdProfile;

  const SearchUserDelletfollowhEvent({
    required this.myuserId,
    required this.userIdProfile,
  });
}
//-----------------------------

class SearchUserAddSearchEvent extends SearchUserEvent {
  final User user;
  const SearchUserAddSearchEvent({
    required this.user,
  });
}

class SearchUserGetAllUserHiveEvent extends SearchUserEvent {}

class SearchUserDeleteSearchEvent extends SearchUserEvent {
  final User user;
  const SearchUserDeleteSearchEvent({
    required this.user,
  });
}

class SearchUserDeleteAllSearchEvent extends SearchUserEvent {}

class SearchUserAddSearchHiveEvent extends SearchUserEvent {
  final User user;
  const SearchUserAddSearchHiveEvent({
    required this.user,
  });
}
