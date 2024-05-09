import 'package:danter/core/constants/variable_onstants.dart';
import 'package:danter/data/model/post.dart';
import 'package:danter/data/repository/auth_repository.dart';

import 'package:danter/screen/write_reply/bloc/write_reply_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendPostReply extends StatelessWidget {
  const SendPostReply({
    super.key,
    required TextEditingController controller,
    required this.postEntity,
    required this.themeData,
    required this.state,
  }) : _controller = controller;

  final TextEditingController _controller;
  final PostEntity postEntity;
  final ThemeData themeData;
  final WriteReplyState state;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_controller.text.isNotEmpty ||
            VariableConstants.selectedImage!.isNotEmpty) {
          BlocProvider.of<WriteReplyBloc>(context).add(WriteReplySendPostEvent(
              user: AuthRepository.readid(),
              text: _controller.text,
              postid: postEntity.id,
              image: VariableConstants.selectedImage!));
        }
      },
      child: Container(
        height: 30,
        width: 55,
        decoration: BoxDecoration(
            color: themeData.colorScheme.primary,
            borderRadius: BorderRadius.circular(20)),
        child: state is WriteReplyLodingState
            ? Center(
                child: SizedBox(
                  height: 23,
                  width: 23,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: themeData.colorScheme.secondary,
                    ),
                  ),
                ),
              )
            : Center(
                child: Text(
                  'Post',
                  style: themeData.textTheme.titleMedium!.copyWith(
                      fontSize: 14, color: themeData.scaffoldBackgroundColor),
                ),
              ),
      ),
    );
  }
}
