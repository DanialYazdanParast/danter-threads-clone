import 'package:bloc/bloc.dart';
import 'package:danter/data/model/follow.dart';

import 'package:danter/data/repository/post_repository.dart';
import 'package:danter/core/util/exceptions.dart';

part 'followers_event.dart';
part 'followers_state.dart';

class FollowersBloc extends Bloc<FollowersEvent, FollowersState> {
  final IPostRepository postRepository;
  FollowersBloc(this.postRepository) : super(FollowersLodingState()) {
    on<FollowersEvent>((event, emit) async {
      if (event is FollowersStartedEvent) {
        try {
          emit(FollowersLodingState());
          final follwers = await postRepository.geAllfollowers(event.user);
          final follwing = await postRepository.geAllfollowing(event.user);
          emit(FollowersSuccesState(follwers, follwing));
        } catch (e) {
          emit(FollowersErrorState(
              exception: e is AppException ? e : AppException()));
        }
      } else if (event is FollowersRefreshEvent) {
        try {
          final follwers = await postRepository.geAllfollowers(event.user);
          final follwing = await postRepository.geAllfollowing(event.user);
          emit(FollowersSuccesState(follwers, follwing));
        } catch (e) {
          emit(FollowersErrorState(
              exception: e is AppException ? e : AppException()));
        }
      } else if (event is FollowersAddfollowhEvent ||
          event is FollowersDelletfollowhEvent ||
          event is FollowingAddfollowhEvent ||
          event is FollowingDelletfollowhEvent ||
          event is FollowersRemovefollowhEvent) {
        if (state is FollowersSuccesState) {
          final successState = (state as FollowersSuccesState);
          if (event is FollowersAddfollowhEvent) {
            await postRepository.addfollow(event.myuserId, event.userIdProfile);
            successState.userFollowers[0].user
                .firstWhere((element) => element.id == event.userIdProfile)
                .followers
                .add(event.myuserId);
          } else if (event is FollowersDelletfollowhEvent) {
            await postRepository.deleteFollow(
                event.myuserId, event.userIdProfile);

            successState.userFollowers[0].user
                .firstWhere((element) => element.id == event.userIdProfile)
                .followers
                .remove(event.myuserId);
          } else if (event is FollowingAddfollowhEvent) {
            await postRepository.addfollow(event.myuserId, event.userIdProfile);
            successState.userFollowing[0].user
                .firstWhere((element) => element.id == event.userIdProfile)
                .followers
                .add(event.myuserId);
          } else if (event is FollowingDelletfollowhEvent) {
            await postRepository.deleteFollow(
                event.myuserId, event.userIdProfile);

            successState.userFollowing[0].user
                .firstWhere((element) => element.id == event.userIdProfile)
                .followers
                .remove(event.myuserId);
          } else if (event is FollowersRemovefollowhEvent) {
            await postRepository.removeFollow(
                event.myuserId, event.userIdProfile);

            successState.userFollowers[0].user
                .removeWhere((element) => element.id == event.userIdProfile);
          }
          emit(FollowersSuccesState(
              successState.userFollowers, successState.userFollowing));
        }
      }
    });
  }
}
