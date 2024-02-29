import 'package:bloc/bloc.dart';
import 'package:danter/data/datasource/messages_datasource.dart';
import 'package:danter/data/model/messageslist.dart';
import 'package:flutter/foundation.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final IchatDataSource data = ChatDataSource();
  ChatBloc() : super(ChatLoding()) {
    data.getStreamChatUser.listen(
      (_) {
        add(ChatSuccesEvent());
      },
    );

    data.getStreamuseronline.listen((_) {
      add(ChatSuccesonlineEvent());
    });

    on<ChatSuccesonlineEvent>((event, emit) {
      if (state is ChatResponseState) {
        final successState = (state as ChatResponseState);
        bool online = data.chatuseronline;
        emit(ChatResponseState(successState.response, online));
      }
    });

    on<ChatSuccesEvent>((event, emit) {
      bool online = data.chatuseronline;
      var result = data.chatuser;
      emit(ChatResponseState(result, online));
    });
    on<ChatInitilzeEvent>((event, emit) async {
      data.realtimeuser(event.myuserid, event.useridchat);
      data.realtimeuseronline(event.useridchat);
      await data.getchatuseronline(event.useridchat);
      await data.getchatuser(event.myuserid, event.useridchat);
    });
    on<SendChatEvent>((event, emit) async {
      if (event.roomid == '') {
        var roomId = await data.addRooomId(event.usersend, event.userseen);
        await data.addChat(event.usersend, event.userseen, event.text, roomId);
      } else {
        await data.addChat(
            event.usersend, event.userseen, event.text, event.roomid);
      }
    });
  }

  @override
  Future<void> close() {
    data.closechatScreen();
    debugPrint('dddddddddddddddddddddddddddddddddddddddddddddddddddddddd');
    return super.close();
  }
}
