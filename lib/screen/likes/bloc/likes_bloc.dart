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
      } 
     
    });
  }
}
