import 'package:danter/data/model/user.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/screen/chat/bloc/chat_bloc.dart';
import 'package:danter/screen/chat/chat_screen.dart';
import 'package:danter/screen/chatList/bloc/messages_bloc.dart';
import 'package:danter/screen/chatList/chat_list_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessagesBloc()
        ..add(MessagesInitilzeEvent(userId: AuthRepository.readid())),
      child: Scaffold(
        appBar: AppBar(
            title: Text('Messages',
                style: Theme.of(context).textTheme.headlineLarge)),
        body: BlocBuilder<MessagesBloc, MessagesState>(
          builder: (context, state) {
            if (state is MessagesLoding) {
              return Center(
                child: SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                      color: Theme.of(context).colorScheme.secondary,
                    )),
              );
            } else if (state is MessagesResponseState) {
              return ListView.builder(
                itemCount: state.response.length,
                itemBuilder: (context, index) {
                  final User user = state.response[index].usersend.id ==
                          AuthRepository.readid()
                      ? state.response[index].usersseen
                      : state.response[index].usersend;
                  return ChatListDetail(
                    onTabFollow: () {},
                    onTabProfile: () {
                      Navigator.of(context, rootNavigator: true)
                          .push(MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => ChatBloc()
                            ..add(ChatInitilzeEvent(
                                myuserid: AuthRepository.readid(),
                                useridchat: user.id)),
                          child: ChatScreen(
                            user: user,
                          ),
                        ),
                      ));
                    },
                    messages: state.response[index],
                  );
                },
              );
            } else {
              throw Exception('state is not supported ');
            }
          },
        ),
      ),
    );
  }
}
