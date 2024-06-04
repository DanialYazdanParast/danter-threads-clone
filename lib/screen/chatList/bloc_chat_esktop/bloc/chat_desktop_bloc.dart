import 'package:bloc/bloc.dart';
import 'package:danter/data/model/user.dart';

part 'chat_desktop_event.dart';
part 'chat_desktop_state.dart';

class ChatDesktopBloc extends Bloc<ChatDesktopEvent, ChatDesktopState> {
  ChatDesktopBloc() : super(ChatDesktopInitial()) {
    on<ChatDesktopEvent>((event, emit) async {
      if (event is ChatDesktopSelectionEvent) {
        final User user = event.user;
        emit(ChatDesktopSelectionState(user));
      }
    });
  }
}
