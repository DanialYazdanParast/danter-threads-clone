import 'package:bloc/bloc.dart';
import 'package:danter/data/model/post.dart';
import 'package:danter/data/repository/post_repository.dart';
import 'package:danter/core/util/exceptions.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IPostRepository postRepository;
  HomeBloc(this.postRepository) : super(HomeLodingState()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeStartedEvent) {
        try {
          emit(HomeLodingState());
          final post = await postRepository.getPost(event.user);
          emit(HomeSuccesState(post));
        } catch (e) {
          emit(HomeErrorState(
              exception: e is AppException ? e : AppException()));
        }
      } else if (event is HomeRefreshEvent) {
        try {
          //     emit(HomeLodingState());
          final post = await postRepository.getPost(event.user);
          emit(HomeSuccesState(post));
        } catch (e) {
          emit(HomeErrorState(
              exception: e is AppException ? e : AppException()));
        }
      } else if (event is AddLikePostEvent || event is RemoveLikePostEvent) {
        if (state is HomeSuccesState) {
          final successState = (state as HomeSuccesState);
          if (event is AddLikePostEvent) {
            await postRepository.addLike(event.user, event.postId);
            successState.post
                .firstWhere((element) => element.id == event.postId)
                .likes
                .add(event.user);
          } else if (event is RemoveLikePostEvent) {
            await postRepository.deleteLike(event.user, event.postId);

            successState.post
                .firstWhere((element) => element.id == event.postId)
                .likes
                .remove(event.user);
          }

          emit(HomeSuccesState(successState.post));
        }
      }
    });
  }
}
