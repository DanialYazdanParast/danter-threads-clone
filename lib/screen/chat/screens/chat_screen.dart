import 'package:danter/core/constants/variable_onstants.dart';
import 'package:danter/core/widgets/image_user_post.dart';
import 'package:danter/data/model/user.dart';
import 'package:danter/screen/chat/bloc/chat_bloc.dart';
import 'package:danter/screen/chat/widgets/chat_detail.dart';
import 'package:danter/screen/chat/widgets/send_hat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  final User user;
  const ChatScreen({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Row(
            children: [
              ImageUserPost(user: user, onTabNameUser: () {}, size: 44),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(user.username,
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
                        throw Exception('state is not supported ');
                      }
                    },
                  ),
                ],
              ),
            ],
          )),
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
                  user: user,
                  response: state.response,
                );
              } else {
                throw Exception('state is not supported ');
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
              user: user,
            ),
          )
        ],
      ),
    );
  }
}
