import 'package:bloc/bloc.dart';
import 'package:danter/data/model/reply.dart';
import 'package:danter/data/repository/rply_repository.dart';
import 'package:danter/util/exceptions.dart';
import 'package:equatable/equatable.dart';

part 'reply_event.dart';
part 'reply_state.dart';

class ReplyBloc extends Bloc<ReplyEvent, ReplyState> {
    final IReplyRepository replyRepository;
  ReplyBloc(this.replyRepository) : super(ReplyLodingState()) {
    on<ReplyEvent>((event, emit) async{

      if (event is ReplyStartedEvent ) {
        try {
          emit(ReplyLodingState());
          final post = await replyRepository.getReply(event.postI);
          emit(ReplySuccesState(post));
        } catch (e) {
          emit(ReplyErrorState(
              exception: e is AppException ? e : AppException()));
        }
      }
      
    });
  }
}
