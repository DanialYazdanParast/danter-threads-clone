part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchStartEvent extends SearchEvent {
  final String userId;

  const SearchStartEvent(this.userId);

  @override
  List<Object> get props => [userId];
}

//---------------------------------------------------
class SearchAddfollowhEvent extends SearchEvent {
  final String myuserId;
  final String userIdProfile;

  const SearchAddfollowhEvent({
    required this.myuserId,
    required this.userIdProfile,
  });
}

class SearchDelletfollowhEvent extends SearchEvent {
  final String myuserId;
  final String userIdProfile;

  const SearchDelletfollowhEvent({
    required this.myuserId,
    required this.userIdProfile,
  });
}
