import 'package:bloc/bloc.dart';
import 'package:danter/data/model/like.dart';
import 'package:danter/data/model/post.dart';
import 'package:danter/data/model/replyphoto.dart';
import 'package:danter/data/repository/post_repository.dart';

import 'package:danter/data/repository/reply_repository.dart';
import 'package:danter/util/exceptions.dart';
import 'package:equatable/equatable.dart';

part 'reply_event.dart';
part 'reply_state.dart';

class ReplyBloc extends Bloc<ReplyEvent, ReplyState> {
    final IReplyRepository replyRepository;
      final IPostRepository postRepository;
  ReplyBloc(this.replyRepository, this.postRepository) : super(ReplyLodingState()) {
    on<ReplyEvent>((event, emit) async{

      if (event is ReplyStartedEvent ) {
        try {
          emit(ReplyLodingState());
          final post = await replyRepository.getReply(event.postId);
           final totallike = await postRepository.getPosttotalLike(event.postId);
          final totareplise =await postRepository.getPosttotalreplise(event.postId);
         
          final trueLikeUser = await postRepository.getLikeuser(event.postId ,event.user);    
        final likeid = await postRepository.getLikeid(event.postId ,event.user);
          emit(ReplySuccesState(post, totallike, totareplise, likeid, trueLikeUser));
        } catch (e) {
          emit(ReplyErrorState(
              exception: e is AppException ? e : AppException()));
        }
      }else if (event is ReplyRefreshEvent ) {
        try {
          final post = await replyRepository.getReply(event.postId);
           final totallike = await postRepository.getPosttotalLike(event.postId);
          final totareplise =await postRepository.getPosttotalreplise(event.postId);
         
          final trueLikeUser = await postRepository.getLikeuser(event.postId ,event.user);    
        final likeid = await postRepository.getLikeid(event.postId ,event.user);
          emit(ReplySuccesState(post, totallike, totareplise, likeid, trueLikeUser));
        } catch (e) {
          emit(ReplyErrorState(
              exception: e is AppException ? e : AppException()));
        }
      }else if (event is AddLikeReplyEvent ) {
        try {
          await postRepository.addLike(event.user ,event.postId);    
          final post = await replyRepository.getReply(event.postId);
           final totallike = await postRepository.getPosttotalLike(event.postId);
          final totareplise =await postRepository.getPosttotalreplise(event.postId);
         
          final trueLikeUser = await postRepository.getLikeuser(event.postId ,event.user);    
        final likeid = await postRepository.getLikeid(event.postId ,event.user);
          emit(ReplySuccesState(post, totallike, totareplise, likeid, trueLikeUser));
        } catch (e) {
          emit(ReplyErrorState(
              exception: e is AppException ? e : AppException()));
        }
      }else if (event is RemoveLikeReplyEvent ) {
        try {
          await postRepository.deleteLike(event.likeId);    
          final post = await replyRepository.getReply(event.postId);
           final totallike = await postRepository.getPosttotalLike(event.postId);
          final totareplise =await postRepository.getPosttotalreplise(event.postId);
         
          final trueLikeUser = await postRepository.getLikeuser(event.postId ,event.user);    
        final likeid = await postRepository.getLikeid(event.postId ,event.user);
          emit(ReplySuccesState(post, totallike, totareplise, likeid, trueLikeUser));
        } catch (e) {
          emit(ReplyErrorState(
              exception: e is AppException ? e : AppException()));
        }
      }
      
    });
  }
}
