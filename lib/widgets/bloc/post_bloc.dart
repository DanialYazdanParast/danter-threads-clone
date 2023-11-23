import 'package:bloc/bloc.dart';
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
              
          emit(PostSuccesState(totallike, totareplise,getPosttotalreplisePhoto ));
        } catch (e) {
          emit(PostErrorState(
              exception: e is AppException ? e : AppException()));
        }
      }
    });
  }
}
