import 'package:danter/core/di/di.dart';
import 'package:danter/data/model/user.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/screen/chat/bloc/chat_bloc.dart';
import 'package:danter/screen/chat/screens/chat_screen.dart';
import 'package:danter/screen/chatList/bloc/messages_bloc.dart';
import 'package:danter/screen/chatList/widgets/chat_list_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessagesBloc(locator.get())
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
              if (state.response.isNotEmpty) {
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
                            create: (context) => ChatBloc(locator.get())
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
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/vecteezy_chat.png',
                        height: 180,
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withAlpha(90),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'your chat list is empty',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                );
              }
            } else {
              throw Exception('state is not supported ');
            }
          },
        ),
      ),
    );
  }
}
