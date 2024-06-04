import 'package:danter/core/constants/variable_onstants.dart';
import 'package:danter/core/widgets/image_user_post.dart';
import 'package:danter/data/model/user.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/screen/chat/bloc/chat_bloc.dart';
import 'package:danter/screen/chat/widgets/chat_detail.dart';
import 'package:danter/screen/chat/widgets/send_hat.dart';
import 'package:danter/screen/root/screens/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  final User user;

  const ChatScreen({
    super.key,
    required this.user,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ChatBloc>(context).add(ChatInitilzeEvent(
        myuserid: AuthRepository.readid(), useridchat: widget.user.id));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: !RootScreen.isMobile(context) ? 20 : 0),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            children: [
              ImageUserPost(user: widget.user, onTabNameUser: () {}, size: 44),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.user.username,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(fontSize: 18, height: 1.2)),
                  BlocBuilder<ChatBloc, ChatState>(
                    builder: (context, state) {
                      if (state is ChatLoding) {
                        return Text('Connecting...',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(height: 1));
                      } else if (state is ChatResponseState) {
                        return Text(state.online ? 'Online' : 'Offline',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(height: 1));
                      } else {
                        return Text('Error',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(height: 1));
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatLoding) {
                  return Center(
                    child: SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(
                          strokeWidth: 1.5,
                          color: Theme.of(context).colorScheme.secondary,
                        )),
                  );
                } else if (state is ChatResponseState) {
                  VariableConstants.roomid =
                      state.response.isNotEmpty ? state.response[0].roomid : '';
                  return ChatDetail(
                    user: widget.user,
                    response: state.response,
                  );
                } else {
                  return const Center(child: Text('Error loading chat'));
                }
              },
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 25,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: SendChat(
                user: widget.user,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
