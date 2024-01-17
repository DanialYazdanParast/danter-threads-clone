import 'package:bloc/bloc.dart';
import 'package:danter/data/repository/reply_repository.dart';
import 'package:danter/core/util/exceptions.dart';
import 'package:equatable/equatable.dart';

part 'write_reply_event.dart';
part 'write_reply_state.dart';

class WriteReplyBloc extends Bloc<WriteReplyEvent, WriteReplyState> {
  final IReplyRepository replypostRepository;
  WriteReplyBloc(this.replypostRepository) : super(WriteReplyInitial()) {
    on<WriteReplyEvent>((event, emit) async {
      if (event is WriteReplySendPostEvent) {
        try {
          emit(WriteReplyLodingState());
          final idPostReply = await replypostRepository.sendPostReply(
              event.user, event.text, event.postid, event.image);
          await replypostRepository.sendidReplyToPost(
            idPostReply,
            event.postid,
          );

          emit(WriteReplySuccesState());
        } catch (e) {
          emit(WriteReplyErrorState(
              exception: e is AppException ? e : AppException()));
        }
      }
    });
  }
}
