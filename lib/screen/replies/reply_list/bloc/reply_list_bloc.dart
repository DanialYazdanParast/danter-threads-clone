import 'package:bloc/bloc.dart';
import 'package:danter/data/model/like.dart';
import 'package:danter/data/model/replyphoto.dart';
import 'package:danter/data/repository/post_repository.dart';
import 'package:danter/data/repository/reply_repository.dart';
import 'package:danter/util/exceptions.dart';
import 'package:equatable/equatable.dart';

part 'reply_list_event.dart';
part 'reply_list_state.dart';

class ReplyListBloc extends Bloc<ReplyListEvent, ReplyListState> {
  final IPostRepository postRepository;
  ReplyListBloc(this.postRepository) : super(ReplyListInitial()) {
    on<ReplyListEvent>((event, emit) async {
      if (event is ReplyListStartedEvent) {
        try {
          emit(ReplyListInitial());

          final totallike = await postRepository.getPosttotalLike(event.postId);
          final totareplise =
              await postRepository.getPosttotalreplise(event.postId);

          final trueLiseUser =
              await postRepository.getLikeuser(event.postId, event.user);
          final likeid =
              await postRepository.getLikeid(event.postId, event.user);
          emit(ReplyListSuccesState(
              totallike, totareplise, trueLiseUser, likeid));
        } catch (e) {
          emit(ReplyListErrorState(
              exception: e is AppException ? e : AppException()));
        }
      }else if (event is AddLikeReplyListEvent) {
        try {
         await postRepository.addLike(event.user ,event.postId);   

          final totallike = await postRepository.getPosttotalLike(event.postId);
          final totareplise =
              await postRepository.getPosttotalreplise(event.postId);

          final trueLiseUser =
              await postRepository.getLikeuser(event.postId, event.user);
          final likeid =
              await postRepository.getLikeid(event.postId, event.user);
          emit(ReplyListSuccesState(
              totallike, totareplise, trueLiseUser, likeid));
        } catch (e) {
          emit(ReplyListErrorState(
              exception: e is AppException ? e : AppException()));
        }
      }else if (event is RemoveLikeReplyListEvent) {
        try {
           await postRepository.deleteLike(event.likeId);    

          final totallike = await postRepository.getPosttotalLike(event.postId);
          final totareplise =
              await postRepository.getPosttotalreplise(event.postId);

          final trueLiseUser =
              await postRepository.getLikeuser(event.postId, event.user);
          final likeid =
              await postRepository.getLikeid(event.postId, event.user);
          emit(ReplyListSuccesState(
              totallike, totareplise, trueLiseUser, likeid));
        } catch (e) {
          emit(ReplyListErrorState(
              exception: e is AppException ? e : AppException()));
        }
      }
    });
  }
}
