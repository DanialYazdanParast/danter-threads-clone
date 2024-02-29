import 'package:bloc/bloc.dart';
import 'package:danter/data/datasource/messages_datasource.dart';
import 'package:danter/data/model/messageslist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'messages_event.dart';
part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  final IchatDataSource data = ChatDataSource();
  MessagesBloc() : super(MessagesLoding()) {
    data.getStreamListMessages.listen((_) {
      add(MessagesSuccesEvent());
    });

    on<MessagesSuccesEvent>((event, emit) async {
      List<MessagesList> result = data.listMessages;
      final newList = result.fold(<MessagesList>[], (prev, curr) {
        if (!prev.any((item) => item.roomid == curr.roomid)) {
          prev.add(curr);
        }
        return prev;
      });
      emit(MessagesResponseState(newList));
    });

    on<MessagesInitilzeEvent>((event, emit) async {
      data.realtime(event.userId);
      data.getListMessages(event.userId);
    });
  }
  @override
  Future<void> close() {
    data.closeMessagesList();
    debugPrint('ffffffffffffffffffffff');
    return super.close();
  }
}
