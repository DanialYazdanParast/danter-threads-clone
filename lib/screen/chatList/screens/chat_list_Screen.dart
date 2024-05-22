import 'package:danter/core/di/di.dart';
import 'package:danter/data/model/user.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/screen/chat/bloc/chat_bloc.dart';
import 'package:danter/screen/chat/screens/chat_screen.dart';
import 'package:danter/screen/chatList/bloc/messages_bloc.dart';
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
  final chatBloc = ChatBloc(locator.get());

  @override
  void dispose() {
    chatBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: chatBloc,
      child: BlocProvider(
        create: (context) => MessagesBloc(locator.get())
          ..add(MessagesInitilzeEvent(userId: AuthRepository.readid())),
        child: Scaffold(
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
                child: BlocConsumer<MessagesBloc, MessagesState>(
                  listener: (context, state) {},
                  buildWhen: (previous, current) {
                    return current is MessagesResponseState ||
                        current is MessagesLoding;
                  },
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
                            final User user =
                                state.response[index].usersend.id ==
                                        AuthRepository.readid()
                                    ? state.response[index].usersseen
                                    : state.response[index].usersend;
                            return ChatListDetail(
                              onTabFollow: () {},
                              onTabProfile: () {
                                if (MediaQuery.of(context).size.width >= 640) {
                                  BlocProvider.of<MessagesBloc>(context).add(
                                    MessagesSelectionEvent(user: user),
                                  );

                                  BlocProvider.of<ChatBloc>(context).add(
                                      ChatInitilzeEvent(
                                          myuserid: AuthRepository.readid(),
                                          useridchat: user.id));
                                } else {
                                  Navigator.of(context, rootNavigator: true)
                                      .push(MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                      create: (context) =>
                                          ChatBloc(locator.get())
                                            ..add(ChatInitilzeEvent(
                                                myuserid:
                                                    AuthRepository.readid(),
                                                useridchat: user.id)),
                                      child: ChatScreen(
                                        user: user,
                                      ),
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
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
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
                  child: VerticalDivider()),
              Visibility(
                visible: !RootScreen.isMobile(context),
                child: Expanded(
                  child: BlocConsumer<MessagesBloc, MessagesState>(
                    listener: (context, state) {},
                    buildWhen: (previous, current) {
                      return current is MessagesSelectionState;
                    },
                    builder: (context, state) {
                      if (state is MessagesSelectionState) {
                        return BlocProvider.value(
                          value: chatBloc
                            ..add(ChatInitilzeEvent(
                                myuserid: AuthRepository.readid(),
                                useridchat: state.user.id)),
                          child: ChatScreen(
                            user: state.user,
                          ),
                        );
                      } else {
                        return Center(
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
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'Send private messages to a friend.',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
