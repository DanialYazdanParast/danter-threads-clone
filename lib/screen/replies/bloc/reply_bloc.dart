import 'package:bloc/bloc.dart';

import 'package:danter/data/model/post.dart';
import 'package:danter/data/repository/post_repository.dart';
import 'package:danter/data/repository/reply_repository.dart';
import 'package:danter/core/util/exceptions.dart';

part 'reply_event.dart';
part 'reply_state.dart';

class ReplyBloc extends Bloc<ReplyEvent, ReplyState> {
  final IReplyRepository replyRepository;
  final IPostRepository postRepository;
  ReplyBloc(this.replyRepository, this.postRepository)
      : super(ReplyLodingState()) {
    on<ReplyEvent>((event, emit) async {
      if (event is ReplyStartedEvent) {
        try {
          final reply = await postRepository.getReplyPost(event.postId);
          final post = await postRepository.getPostReply(event.postId);
          emit(ReplySuccesState(post, reply));
        } catch (e) {
          emit(ReplyErrorState(
              exception: e is AppException ? e : AppException()));
        }
      } else if (event is ReplyRefreshEvent) {
        try {
          //    emit(ReplyLodingState());
          final reply = await postRepository.getReplyPost(event.postId);
          final post = await postRepository.getPostReply(event.postId);
          emit(ReplySuccesState(post, reply));
        } catch (e) {
          emit(ReplyErrorState(
              exception: e is AppException ? e : AppException()));
        }
      } else if (event is AddLikePostEvent ||
          event is RemoveLikePostEvent ||
          event is AddLikeRplyEvent ||
          event is RemoveLikeRplyEvent) {
        if (state is ReplySuccesState) {
          final successState = (state as ReplySuccesState);
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
          } else if (event is AddLikeRplyEvent) {
            await postRepository.addLike(event.user, event.postId);
            successState.reply
                .firstWhere((element) => element.id == event.postId)
                .likes
                .add(event.user);
          } else if (event is RemoveLikeRplyEvent) {
            await postRepository.deleteLike(event.user, event.postId);

            successState.reply
                .firstWhere((element) => element.id == event.postId)
                .likes
                .remove(event.user);
          }

          emit(ReplySuccesState(successState.post, successState.reply));
        }
      }
    });
  }
}
