import 'package:danter/core/constants/variable_onstants.dart';
import 'package:danter/data/model/user.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/screen/chat/bloc/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                                roomid: VariableConstants.roomid),
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
