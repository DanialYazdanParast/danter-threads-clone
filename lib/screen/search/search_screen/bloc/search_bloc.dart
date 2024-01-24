import 'package:bloc/bloc.dart';
import 'package:danter/core/util/exceptions.dart';
import 'package:danter/data/model/user.dart';
import 'package:danter/data/repository/post_repository.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final IPostRepository postRepository;
  SearchBloc(this.postRepository) : super(SearchLodingState()) {
    on<SearchEvent>((event, emit) async {
      if (event is SearchStartEvent) {
        try {
          final user = await postRepository.getAllUser(event.userId);
          emit(SearchSuccesState(user));
        } catch (e) {
          emit(SearchErrorState(
              exception: e is AppException ? e : AppException()));
        }
      } else if (event is SearchAddfollowhEvent ||
          event is SearchDelletfollowhEvent) {
        if (state is SearchSuccesState) {
          final successState = (state as SearchSuccesState);
          if (event is SearchAddfollowhEvent) {
            await postRepository.addfollow(event.myuserId, event.userIdProfile);
            successState.user
                .firstWhere((element) => element.id == event.userIdProfile)
                .followers
                .add(event.myuserId);
          } else if (event is SearchDelletfollowhEvent) {
            await postRepository.deleteFollow(
                event.myuserId, event.userIdProfile);

            successState.user
                .firstWhere((element) => element.id == event.userIdProfile)
                .followers
                .remove(event.myuserId);
          }

          emit(SearchSuccesState(successState.user));
        }
      }
    });
  }
}
