import 'package:danter/core/constants/variable_onstants.dart';
import 'package:danter/data/model/post.dart';
import 'package:danter/core/di/di.dart';

import 'package:danter/screen/replies/bloc/reply_bloc.dart';
import 'package:danter/core/widgets/snackbart.dart';
import 'package:danter/core/widgets/write.dart';
import 'package:danter/screen/root/screens/root.dart';
import 'package:danter/screen/write_reply/bloc/write_reply_bloc.dart';
import 'package:danter/screen/write_reply/widgets/post_write.dart';
import 'package:danter/screen/write_reply/widgets/send_post_reply.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WriteReply extends StatefulWidget {
  final PostEntity postEntity;
  final String namePage;

  const WriteReply(
      {super.key, required this.postEntity, required this.namePage});

  @override
  State<WriteReply> createState() => _WriteReplyState();
}

class _WriteReplyState extends State<WriteReply> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return BlocProvider(
      create: (context) => WriteReplyBloc(locator.get()),
      child: Padding(
        padding: EdgeInsets.only(top: !RootScreen.isMobile(context) ? 20 : 0),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Reply'),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: Divider(
                  height: 1,
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                  thickness: 0.7),
            ),
          ),
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned.fill(
                top: 0,
                right: 0,
                left: 0,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      PostWrite(
                          postEntity: widget.postEntity,
                          namePage: widget.namePage),
                      FildWrite(
                        controller: _controller,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  color: themeData.scaffoldBackgroundColor,
                  height: 45,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Anyone can reply',
                            style: Theme.of(context).textTheme.labelSmall),
                        BlocConsumer<WriteReplyBloc, WriteReplyState>(
                          listener: (context, state) {
                            if (state is WriteReplySuccesState) {
                              _controller.text = '';
                              VariableConstants.selectedImage = [];
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                snackBarApp(
                                    themeData,
                                    'با موفقیت ثبت شد',
                                    (widget.namePage == 'reply') ? 55 : 10,
                                    context),
                              );
                              if (widget.namePage == 'reply') {
                                BlocProvider.of<ReplyBloc>(context)
                                    .add(ReplyRefreshEvent(
                                  postId: widget.postEntity.id,
                                ));
                              }
                            } else if (state is WriteReplyErrorState) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  snackBarApp(
                                      themeData,
                                      state.exception.message,
                                      (widget.namePage == 'reply') ? 55 : 10,
                                      context));
                            }
                          },
                          builder: (context, state) {
                            return SendPostReply(
                              controller: _controller,
                              postEntity: widget.postEntity,
                              themeData: themeData,
                              state: state,
                            );
                          },
                        ),
                      ],
                    ),
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
