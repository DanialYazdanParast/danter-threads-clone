import 'package:bloc/bloc.dart';
import 'package:danter/data/model/like.dart';
import 'package:danter/data/model/replyphoto.dart';
import 'package:danter/data/repository/post_repository.dart';
import 'package:danter/util/exceptions.dart';
import 'package:equatable/equatable.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final IPostRepository postRepository;
  PostBloc(this.postRepository) : super(PostInitial()) {
    on<PostEvent>((event, emit) async {
      if (event is PostStartedEvent) {
        try {
          emit(PostInitial());
          final totallike = await postRepository.getPosttotalLike(event.postId);
          final totareplise =await postRepository.getPosttotalreplise(event.postId);
          final getPosttotalreplisePhoto = await postRepository.getPosttotalreplisePhoto(event.postId);
          final trueLiseUser = await postRepository.getLikeuser(event.postId ,event.user);    
        final likeid = await postRepository.getLikeid(event.postId ,event.user);
          emit(PostSuccesState(totallike, totareplise, getPosttotalreplisePhoto ,trueLiseUser, likeid));
        } catch (e) {
          emit(PostErrorState(
              exception: e is AppException ? e : AppException()));
        }
      } else if (event is AddLikePostEvent) {
        try {
       //   emit(PostInitial());
          await postRepository.addLike(event.user ,event.postId);    
          final totallike = await postRepository.getPosttotalLike(event.postId);
          final totareplise =await postRepository.getPosttotalreplise(event.postId);
          final getPosttotalreplisePhoto = await postRepository.getPosttotalreplisePhoto(event.postId);
          final trueLiseUser = await postRepository.getLikeuser(event.postId ,event.user);    
       final likeid = await postRepository.getLikeid(event.postId ,event.user);
          emit(PostSuccesState(totallike, totareplise, getPosttotalreplisePhoto ,trueLiseUser, likeid));
        } catch (e) {
          emit(PostErrorState(
              exception: e is AppException ? e : AppException()));
        }
      }else if (event is RemoveLikePostEvent ) {
        try {
       //   emit(PostInitial());
          await postRepository.deleteLike(event.likeId);    
          final totallike = await postRepository.getPosttotalLike(event.postId);
          final totareplise =await postRepository.getPosttotalreplise(event.postId);
          final getPosttotalreplisePhoto = await postRepository.getPosttotalreplisePhoto(event.postId);
          final trueLiseUser = await postRepository.getLikeuser(event.postId ,event.user);    
         final likeid = await postRepository.getLikeid(event.postId ,event.user);
          emit(PostSuccesState(totallike, totareplise, getPosttotalreplisePhoto ,trueLiseUser, likeid));
        } catch (e) {
          emit(PostErrorState(
              exception: e is AppException ? e : AppException()));
        }
      }
    });
  }
}
