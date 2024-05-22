import 'package:bloc/bloc.dart';
import 'package:danter/core/util/exceptions.dart';
import 'package:danter/data/model/user.dart';
import 'package:danter/data/repository/post_repository.dart';
import 'package:danter/data/repository/search_user_repository.dart';
import 'package:equatable/equatable.dart';

part 'search_user_event.dart';
part 'search_user_state.dart';

class SearchUserBloc extends Bloc<SearchUserEvent, SearchUserState> {
  final IPostRepository postRepository;
  final ISearchUserRepository searchUserRepository;
  SearchUserBloc(this.postRepository, this.searchUserRepository)
      : super(SearchUserInitial()) {
    on<SearchUserEvent>((event, emit) async {
      if (event is SearchUserKeyUsernameEvent) {
        try {
          emit(SearchUserLodingState());
          if (event.keyUsername != '') {
            final user = await postRepository.getSearchUser(
                event.keyUsername, event.userId);
            emit(SearchUserSuccesState(user));
          } else {
            final user = await searchUserRepository.getAllSearchUser();
            emit(SearchUserHiveSuccesState(user));
          }
        } catch (e) {
          emit(SearchUserErrorState(
              exception: e is AppException ? e : AppException()));
        }
      } else if (event is SearchUserAddfollowhEvent ||
          event is SearchUserDelletfollowhEvent) {
        if (state is SearchUserSuccesState) {
          final successState = (state as SearchUserSuccesState);
          if (event is SearchUserAddfollowhEvent) {
            await postRepository.addfollow(event.myuserId, event.userIdProfile);
            successState.user
                .firstWhere((element) => element.id == event.userIdProfile)
                .followers
                .add(event.myuserId);
          } else if (event is SearchUserDelletfollowhEvent) {
            await postRepository.deleteFollow(
                event.myuserId, event.userIdProfile);
            successState.user
                .firstWhere((element) => element.id == event.userIdProfile)
                .followers
                .remove(event.myuserId);
          }
          emit(SearchUserSuccesState(successState.user));
        }
      } else if (event is SearchUserGetAllUserHiveEvent) {
        final user = await searchUserRepository.getAllSearchUser();
        emit(SearchUserHiveSuccesState(user));
      } else if (event is SearchUserAddSearchEvent) {
        final user = await searchUserRepository.getAllSearchUser();
        final isconst = user.where((element) => element.id == event.user.id);
        if (isconst.isNotEmpty) {
          await searchUserRepository.deleteSearchUser(isconst.first);
          await searchUserRepository.addSearchUser(event.user);
        } else {
          await searchUserRepository.addSearchUser(event.user);
        }
      } else if (event is SearchUserDeleteSearchEvent) {
        await searchUserRepository.deleteSearchUser(event.user);
        final user = await searchUserRepository.getAllSearchUser();
        emit(SearchUserHiveSuccesState(user));
      } else if (event is SearchUserDeleteAllSearchEvent) {
        await searchUserRepository.deleteAllSearchUser();
        final user = await searchUserRepository.getAllSearchUser();
        emit(SearchUserHiveSuccesState(user));
      } else if (event is SearchUserAddSearchHiveEvent) {
        await searchUserRepository.deleteSearchUser(event.user);
        await searchUserRepository.addSearchUser(event.user);
        final user = await searchUserRepository.getAllSearchUser();
        emit(SearchUserHiveSuccesState(user));
      }
    });
  }
}
