import 'package:bloc/bloc.dart';
import 'package:danter/data/model/follow.dart';
import 'package:danter/data/repository/post_repository.dart';
import 'package:danter/util/exceptions.dart';
import 'package:equatable/equatable.dart';

part 'liked_detail_event.dart';
part 'liked_detail_state.dart';

class LikedDetailBloc extends Bloc<LikedDetailEvent, LikedDetailState> {
  final IPostRepository postRepository;
  LikedDetailBloc(this.postRepository) : super(LikedDetailInitial()) {
    on<LikedDetailEvent>((event, emit) async {
      if (event is LikedDetailStartedEvent) {
        try {
          emit(LikedDetailInitial());
          final truefollowing = await postRepository.getTruefollowing(
              event.myuserId, event.userIdProfile);
          final followid = await postRepository.getFollowid(
              event.myuserId, event.userIdProfile);
          emit(LikedDetailSuccesState(followid, truefollowing));
        } catch (e) {
          emit(LikedDetailErrorState(
              exception: e is AppException ? e : AppException()));
        }
      }else if (event is LikedDetailAddfollowhEvent) {
        try {
          await postRepository.addfollow(event.myuserId,event.userIdProfile);
          final truefollowing = await postRepository.getTruefollowing(
              event.myuserId, event.userIdProfile);
          final followid = await postRepository.getFollowid(
              event.myuserId, event.userIdProfile);
          emit(LikedDetailSuccesState(followid, truefollowing));
        } catch (e) {
          emit(LikedDetailErrorState(
              exception: e is AppException ? e : AppException()));
        }
      }else if (event is LikedDetailDelletfollowhEvent) {
        try {
            await postRepository.deleteFollow(event.followId);
          final truefollowing = await postRepository.getTruefollowing(
              event.myuserId, event.userIdProfile);
          final followid = await postRepository.getFollowid(
              event.myuserId, event.userIdProfile);
          emit(LikedDetailSuccesState(followid, truefollowing));
        } catch (e) {
          emit(LikedDetailErrorState(
              exception: e is AppException ? e : AppException()));
        }
      }else if (event is LikedDetailRefreshEvent) {
        try {
          
          final truefollowing = await postRepository.getTruefollowing(
              event.myuserId, event.userIdProfile);
          final followid = await postRepository.getFollowid(
              event.myuserId, event.userIdProfile);
          emit(LikedDetailSuccesState(followid, truefollowing));
        } catch (e) {
          emit(LikedDetailErrorState(
              exception: e is AppException ? e : AppException()));
        }
      }
    });
  }
}
