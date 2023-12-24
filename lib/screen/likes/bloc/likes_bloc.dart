import 'package:bloc/bloc.dart';
import 'package:danter/data/model/follow.dart';
import 'package:danter/data/model/like.dart';
import 'package:danter/data/repository/post_repository.dart';

import 'package:danter/util/exceptions.dart';
import 'package:equatable/equatable.dart';

part 'likes_event.dart';
part 'likes_state.dart';

class LikesBloc extends Bloc<LikesEvent, LikesState> {
   final IPostRepository postRepository;
  LikesBloc(this.postRepository) : super(LikesLodingState()) {
    on<LikesEvent>((event, emit) async{
       if (event is LikesStartedEvent ) {
        try {
          emit(LikesLodingState());
          final allLikePost = await postRepository.getAllLikePost(event.postId);
          emit(LikesSuccesState(allLikePost ));
        } catch (e) {
          emit(LikesErrorState(
              exception: e is AppException ? e : AppException()));
        }
      }  else if (event is LikedAddfollowhEvent || event is LikedDelletfollowhEvent) {
        if (state is LikesSuccesState) {
          final successState = (state as LikesSuccesState);
          if (event is LikedAddfollowhEvent) {
            await postRepository.addfollow(event.myuserId, event.userIdProfile);
            successState.user[0].user
                .firstWhere((element) => element.id == event.userIdProfile)
                .followers
                .add(event.myuserId);
          } else if (event is LikedDelletfollowhEvent) {
            await postRepository.deleteFollow(event.myuserId, event.userIdProfile);

             successState.user[0].user
                .firstWhere((element) => element.id == event.userIdProfile)
                .followers
                .remove(event.myuserId);
          }

          emit(LikesSuccesState(successState.user));
        }
      }
     
    });
  }
}
