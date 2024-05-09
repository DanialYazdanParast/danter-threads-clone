import 'package:danter/core/widgets/post_detail.dart';
import 'package:danter/data/model/post.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/screen/profile_user/bloc/profile_user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DanterProfileUser extends StatelessWidget {
  const DanterProfileUser({super.key, required this.post});

  final List<PostEntity> post;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        (post.isNotEmpty)
            ? SliverList.builder(
                itemCount: post.length,
                itemBuilder: (context, index) {
                  return PostDetail(
                      namepage: 'ProfileUser',
                      onTabLike: () {
                        if (!post[index]
                            .likes
                            .contains(AuthRepository.readid())) {
                          BlocProvider.of<ProfileUserBloc>(context).add(
                            AddLikeProfileUserEvent(
                              postId: post[index].id,
                              user: AuthRepository.readid(),
                            ),
                          );
                        } else {
                          BlocProvider.of<ProfileUserBloc>(context).add(
                            RemoveLikeProfileUserEvent(
                              postId: post[index].id,
                              user: AuthRepository.readid(),
                            ),
                          );
                        }
                      },
                      postEntity: post[index],
                      onTabmore: () {});
                },
              )
            : SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: Text('No danter yet',
                        style: Theme.of(context).textTheme.titleSmall),
                  ),
                ),
              ),
      ],
    );
  }
}
