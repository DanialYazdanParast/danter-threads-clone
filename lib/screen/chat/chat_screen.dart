import 'package:danter/core/extensions/global_extensions.dart';
import 'package:danter/core/widgets/image_user_post.dart';
import 'package:danter/data/model/messageslist.dart';
import 'package:danter/data/model/user.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/screen/chat/bloc/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

String roomid = '';

class ChatScreen extends StatelessWidget {
  final User user;
  ChatScreen({
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
              Hero(
                tag: user.id,
                child:
                    ImageUserPost(user: user, onTabNameUser: () {}, size: 44),
              ),
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
                roomid =
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

class ChatDetail extends StatelessWidget {
  const ChatDetail({
    super.key,
    required this.user,
    required this.response,
  });
  final List<MessagesList> response;
  final User user;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemCount: response.length,
      itemBuilder: (context, index) {
        bool trueusersend =
            response[index].usersend.id == AuthRepository.readid();

        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment:
              trueusersend ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, bottom: index == 0 ? 66 : 0),
              child: Visibility(
                visible: !trueusersend,
                child:
                    ImageUserPost(user: user, onTabNameUser: () {}, size: 30),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(4, 4, 10, index == 0 ? 66 : 0),
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.66),
              padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).colorScheme.secondary),
                  color: response[index].usersend.id == AuthRepository.readid()
                      ?
                      //Theme.of(context).colorScheme.onBackground,
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.8)
                      : Theme.of(context).colorScheme.onBackground,

                  //    const Color.fromARGB(255, 227, 3, 247),
                  //   gradient: LinearGradient(
                  //   //  begin: Alignment.topLeft,
                  //  //   end: Alignment.bottomRight,
                  //     colors: [

                  //     Color(0xff00b2e7),
                  //   //  Color(0xffe064f7),
                  //   //  Color(0xffff8d6c),
                  //   ]),
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(15),
                    bottomLeft: trueusersend
                        ? const Radius.circular(15)
                        : const Radius.circular(0),
                    topRight: const Radius.circular(15),
                    bottomRight: trueusersend
                        ? const Radius.circular(0)
                        : const Radius.circular(15),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment:
                    response[index].usersend.id == AuthRepository.readid()
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                children: [
                  Text(response[index].text,
                      textDirection: TextDirection.rtl,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 18,
                          height: 1.4,
                          color: response[index].usersend.id ==
                                  AuthRepository.readid()
                              ? Theme.of(context).scaffoldBackgroundColor
                              : Theme.of(context).colorScheme.onPrimary)),
                  Text(response[index].created.time(),
                      textDirection: TextDirection.rtl,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 12,
                          height: 1.4,
                          color: response[index].usersend.id ==
                                  AuthRepository.readid()
                              ? Theme.of(context).scaffoldBackgroundColor
                              : Theme.of(context).colorScheme.onPrimary))
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class SendChat extends StatelessWidget {
  SendChat({
    super.key,
    required this.user,
  });
  final TextEditingController textController = TextEditingController();
  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: SizedBox(
          //height: 50,
          child: TextFormField(
              controller: textController,
              onChanged: (value) {},
              maxLines: 5,
              minLines: 1,
              decoration: InputDecoration(
                  filled: true,
                  hintText: 'Type here ...',
                  hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                        height: 1.4,
                      ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 20.0),
                  suffixIcon: IconButton(
                      onPressed: () {
                        if (textController.text != "") {
                          BlocProvider.of<ChatBloc>(context).add(
                            SendChatEvent(
                                usersend: AuthRepository.readid(),
                                userseen: user.id,
                                text: textController.text,
                                roomid: roomid),
                          );

                          textController.clear();
                        }
                      },
                      icon: const Icon(
                        Icons.send,
                      )),
                  fillColor: Theme.of(context).colorScheme.onBackground)),
        ),
      ),
    );
  }
}
