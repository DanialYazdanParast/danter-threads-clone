import 'package:bloc/bloc.dart';
import 'package:danter/data/model/follow.dart';
import 'package:danter/data/repository/post_repository.dart';
import 'package:danter/util/exceptions.dart';
import 'package:equatable/equatable.dart';

part 'followers_page_event.dart';
part 'followers_page_state.dart';

class FollowersPageBloc extends Bloc<FollowersPageEvent, FollowersPageState> {
  final IPostRepository postRepository;
  FollowersPageBloc(this.postRepository) : super(FollowersPageInitial()) {
    on<FollowersPageEvent>((event, emit) async {
      if (event is FollowersPageStartedEvent) {
        try {
          emit(FollowersPageInitial());
          final truefollowing = await postRepository.getTruefollowing(
              event.myuserId, event.userIdProfile);
                   final followid = await postRepository.getFollowid(
              event.myuserId, event.userIdProfile);
          emit(FollowersPageSuccesState(truefollowing ,followid));
        } catch (e) {
          emit(FollowersPageErrorState(
              exception: e is AppException ? e : AppException()));
        }
      }else if (event is FollowersPageAddfollowhEvent) {
        try {
            await postRepository.addfollow(event.myuserId,event.userIdProfile);
          final truefollowing = await postRepository.getTruefollowing(
              event.myuserId, event.userIdProfile);
           final followid = await postRepository.getFollowid(
              event.myuserId, event.userIdProfile);
          emit(FollowersPageSuccesState(truefollowing ,followid));
        } catch (e) {
          emit(FollowersPageErrorState(
              exception: e is AppException ? e : AppException()));
        }
      }else if (event is FollowersPageDelletfollowhEvent) {
        try {
          await postRepository.deleteFollow(event.followId);
          final truefollowing = await postRepository.getTruefollowing(
              event.myuserId, event.userIdProfile);
          final followid = await postRepository.getFollowid(
              event.myuserId, event.userIdProfile);
          emit(FollowersPageSuccesState(truefollowing ,followid));
        } catch (e) {
          emit(FollowersPageErrorState(
              exception: e is AppException ? e : AppException()));
        }
      }
    });
  }
}
