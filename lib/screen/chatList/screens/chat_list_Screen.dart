import 'package:danter/data/model/user.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/screen/chat/bloc/chat_bloc.dart';
import 'package:danter/screen/chat/screens/chat_screen.dart';
import 'package:danter/screen/chatList/bloc/messages_bloc.dart';
import 'package:danter/screen/chatList/bloc_chat_esktop/bloc/chat_desktop_bloc.dart';
import 'package:danter/screen/chatList/widgets/chat_list_detail.dart';
import 'package:danter/screen/root/screens/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MessagesBloc>(context)
        .add(MessagesInitilzeEvent(userId: AuthRepository.readid()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RootScreen.isMobile(context)
          ? AppBar(
              title: Text('Messages',
                  style: Theme.of(context).textTheme.headlineLarge))
          : null,
      body: Row(
        children: [
          SizedBox(
            width: RootScreen.isTablet(context)
                ? 250
                : RootScreen.isDesktop(context)
                    ? 300
                    : MediaQuery.of(context).size.width,
            child: BlocBuilder<MessagesBloc, MessagesState>(
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
                      padding: EdgeInsets.only(
                          top: RootScreen.isMobile(context) ? 0 : 30),
                      itemCount: state.response.length,
                      itemBuilder: (context, index) {
                        final User user = state.response[index].usersend.id ==
                                AuthRepository.readid()
                            ? state.response[index].usersseen
                            : state.response[index].usersend;

                        return ChatListDetail(
                          onTabuser: () {
                            if (!RootScreen.isMobile(context)) {
                              context.read<ChatDesktopBloc>().add(
                                    ChatDesktopSelectionEvent(user: user),
                                  );
                            } else {
                              Navigator.of(context, rootNavigator: true)
                                  .push(MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                  user: user,
                                ),
                              ));
                            }
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
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
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
          Visibility(
            visible: !RootScreen.isMobile(context),
            child: const VerticalDivider(),
          ),
          if (!RootScreen.isMobile(context))
            BlocConsumer<ChatDesktopBloc, ChatDesktopState>(
              listener: (context, state) {
                if (state is ChatDesktopSelectionState) {
                  context.read<ChatBloc>().add(ChatInitilzeEvent(
                      myuserid: AuthRepository.readid(),
                      useridchat: state.user.id));
                }
              },
              builder: (context, state) {
                if (state is ChatDesktopSelectionState) {
                  return Expanded(
                    child: ChatScreen(
                      user: state.user,
                    ),
                  );
                } else if (state is ChatDesktopInitial) {
                  return Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/nochat.png',
                            height: 80,
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withAlpha(90),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Your messages',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    fontSize: 14,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'Send private messages to a friend.',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  throw Exception('state is not supported');
                }
              },
            ),
        ],
      ),
    );
  }
}
