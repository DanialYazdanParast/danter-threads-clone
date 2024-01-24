import 'package:danter/core/constants/custom_colors.dart';
import 'package:danter/data/model/post.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/core/di/di.dart';
import 'package:danter/screen/replies/bloc/reply_bloc.dart';
import 'package:danter/screen/replies/write_reply/bloc/write_reply_bloc.dart';
import 'package:danter/core/widgets/image.dart';
import 'package:danter/core/widgets/image_post.dart';
import 'package:danter/core/widgets/snackbart.dart';
import 'package:danter/core/widgets/write.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WriteReply extends StatelessWidget {
  final PostEntity postEntity;
  final String namePage;

  WriteReply({super.key, required this.postEntity, required this.namePage});
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return BlocProvider(
      create: (context) => WriteReplyBloc(locator.get()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Reply'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0.0),
            child: Divider(
                height: 1,
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
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
                    PostWrite(postEntity: postEntity),
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
                            selectedImage = [];
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              snackBarApp(themeData, 'با موفقیت ثبت شد',
                                  (namePage == 'reply') ? 55 : 10),
                            );
                            if (namePage == 'reply') {
                              BlocProvider.of<ReplyBloc>(context)
                                  .add(ReplyRefreshEvent(
                                postId: postEntity.id,
                              ));
                            }
                          } else if (state is WriteReplyErrorState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                snackBarApp(themeData, state.exception.message,
                                    (namePage == 'reply') ? 55 : 10));
                          }
                        },
                        builder: (context, state) {
                          return GestureDetector(
                            onTap: () {
                              if (_controller.text.isNotEmpty ||
                                  selectedImage!.isNotEmpty) {
                                BlocProvider.of<WriteReplyBloc>(context).add(
                                    WriteReplySendPostEvent(
                                        user: AuthRepository.readid(),
                                        text: _controller.text,
                                        postid: postEntity.id,
                                        image: selectedImage!));
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
                                            color:
                                                themeData.colorScheme.secondary,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        'Post',
                                        style: themeData.textTheme.titleMedium!
                                            .copyWith(
                                                fontSize: 14,
                                                color: themeData
                                                    .scaffoldBackgroundColor),
                                      ),
                                    ),
                            ),
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
    );
  }
}

class PostWrite extends StatelessWidget {
  final PostEntity postEntity;
  const PostWrite({
    super.key,
    required this.postEntity,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Positioned(
              left: 28,
              top: 53,
              bottom: 0,
              child: Container(
                width: 1,
                color: LightThemeColors.secondaryTextColor,
              )),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (postEntity.user.avatarchek.isNotEmpty)
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: SizedBox(
                                height: 40,
                                width: 40,
                                child: ImageLodingService(
                                    imageUrl: postEntity.user.avatar)),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                                height: 40,
                                width: 40,
                                child:
                                    Image.asset('assets/images/profile.png')),
                          ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              postEntity.user.username,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 7, right: 7),
                              child: Text(
                                postEntity.text,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ImagePost(postEntity: postEntity),
            ],
          ),
        ],
      ),
    );
  }
}
