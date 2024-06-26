import 'package:bloc/bloc.dart';
import 'package:danter/data/repository/post_repository.dart';
import 'package:danter/core/util/exceptions.dart';
import 'package:equatable/equatable.dart';

part 'write_event.dart';
part 'write_state.dart';

class WriteBloc extends Bloc<WriteEvent, WriteState> {
  final IPostRepository postRepository;
  WriteBloc(this.postRepository) : super(WriteInitial()) {
    on<WriteEvent>((event, emit) async {
      if (event is WriteSendPostEvent) {
        try {
          emit(WriteLodingState());
          await postRepository.sendPost(event.user, event.text, event.image);
          emit(WriteSuccesState());
        } catch (e) {
          emit(WriteErrorState(
              exception: e is AppException ? e : AppException()));
        }
      }
    });
  }
}
