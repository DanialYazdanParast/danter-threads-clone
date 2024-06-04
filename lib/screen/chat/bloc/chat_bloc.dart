import 'package:bloc/bloc.dart';

import 'package:danter/data/model/messageslist.dart';
import 'package:danter/data/repository/messages_repository.dart';

import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

String myuserid = '';

String useridchat = '';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final IchatRepository data;

  ChatBloc(this.data) : super(ChatLoding()) {
    data.getStreamChatUser.listen((_) {
      add(const ChatSuccesEvent());
    });

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

    on<ChatSuccesEvent>((event, emit) async {
      bool online = data.chatuseronline;

      //   var result = data.chatuser;

      var result = await data.getchatuser(myuserid, useridchat);
      print(result.length);
      emit(ChatResponseState(result, online));
    });

    on<ChatInitilzeEvent>((event, emit) async {
      emit(ChatLoding());
      myuserid = event.myuserid;
      useridchat = event.useridchat;

      data.realtimeuser(event.myuserid, event.useridchat);
      data.realtimeuseronline(event.useridchat);
      await data.getchatuseronline(event.useridchat);
      await data.getchatuser(event.myuserid, event.useridchat);
      var result = await data.getchatuser(myuserid, useridchat);
      emit(ChatResponseState(result, data.chatuseronline));
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
    return super.close();
  }
}
