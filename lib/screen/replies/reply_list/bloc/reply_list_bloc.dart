import 'package:bloc/bloc.dart';
import 'package:danter/data/repository/reply_repository.dart';
import 'package:danter/util/exceptions.dart';
import 'package:equatable/equatable.dart';

part 'reply_list_event.dart';
part 'reply_list_state.dart';

class ReplyListBloc extends Bloc<ReplyListEvent, ReplyListState> {
   final IReplyRepository replyRepository;
  ReplyListBloc(this.replyRepository) : super(ReplyListInitial()) {
    on<ReplyListEvent>((event, emit) async {
      if (event is ReplyListStartedEvent) {
        try {
          emit(ReplyListInitial());
         final totallike = await replyRepository.getReplytotalLike(event.replyId);
         final totareplise =await replyRepository.getReplytotalreplise(event.replyId);
     //     final getPosttotalreplisePhoto = await postRepository.getPosttotalreplisePhoto(event.postId);
              
         emit(ReplyListSuccesState(totallike,totareplise));
        } catch (e) {
          emit(ReplyListErrorState(
              exception: e is AppException ? e : AppException()));
 
      }
       }
    });
  }
}
