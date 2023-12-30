import 'package:bloc/bloc.dart';
import 'package:danter/data/model/follow.dart';
import 'package:danter/data/model/post.dart';
import 'package:danter/data/model/user.dart';
import 'package:danter/data/repository/post_repository.dart';
import 'package:danter/util/exceptions.dart';
import 'package:equatable/equatable.dart';

part 'profile_user_event.dart';
part 'profile_user_state.dart';

class ProfileUserBloc extends Bloc<ProfileUserEvent, ProfileUserState> {
  final IPostRepository postRepository;
  ProfileUserBloc(this.postRepository) : super(ProfileUserLodingState()) {
    on<ProfileUserEvent>((event, emit) async {
      if (event is ProfileUserStartedEvent) {
        try {
          emit(ProfileUserLodingState());
          final post = await postRepository.getPostProfile(event.user);

          final follwers = await postRepository.geAllfollowers(event.user);
          final reply = await postRepository.getAllReply(event.user);
          final user = await postRepository.getUser(event.user);
          emit(ProfileUserSuccesState(post, follwers, reply, user));
        } catch (e) {
          emit(ProfileUserErrorState(
              exception: e is AppException ? e : AppException()));
        }
      } else if (event is ProfileUserRefreshEvent) {
        try {
          final post = await postRepository.getPostProfile(event.user);
          final follwers = await postRepository.geAllfollowers(event.user);
          final reply = await postRepository.getAllReply(event.user);
          final user = await postRepository.getUser(event.user);
          emit(ProfileUserSuccesState(post, follwers, reply, user));
        } catch (e) {
          emit(ProfileUserErrorState(
              exception: e is AppException ? e : AppException()));
        }
      } else if (event is ProfileUserAddfollowhEvent ||
          event is ProfileUserDelletfollowhEvent) {
        if (state is ProfileUserSuccesState) {
          final successState = (state as ProfileUserSuccesState);
          if (event is ProfileUserAddfollowhEvent) {
            await postRepository.addfollow(event.myuserId, event.userIdProfile);
            successState.user.followers.add(event.myuserId);
            final follwers =
                await postRepository.geAllfollowers(event.userIdProfile);
            successState.userFollowers = follwers;
          } else if (event is ProfileUserDelletfollowhEvent) {
            await postRepository.deleteFollow(
                event.myuserId, event.userIdProfile);
            successState.user.followers.remove(event.myuserId);
            final follwers =
                await postRepository.geAllfollowers(event.userIdProfile);
            successState.userFollowers = follwers;
          }
          emit(ProfileUserSuccesState(
              successState.post,
              successState.userFollowers,
              successState.reply,
              successState.user));
        }
      }else if (event is AddLikeProfileUserEvent ||
          event is RemoveLikeProfileUserEvent ||
          event is AddLikeReplyToProfileUserEvent ||
          event is RemoveLikeReplyToProfileUserEvent ||
          event is AddLikeMyReplyProfileUserEvent ||
          event is RemoveLikeMyReplyProfileUserEvent) {
        if (state is ProfileUserSuccesState) {
          final successState = (state as ProfileUserSuccesState);
          if (event is AddLikeProfileUserEvent) {
            await postRepository.addLike(event.user, event.postId);
            successState.post
                .firstWhere((element) => element.id == event.postId)
                .likes
                .add(event.user);
          } else if (event is RemoveLikeProfileUserEvent) {
            await postRepository.deleteLike(event.user, event.postId);

            successState.post
                .firstWhere((element) => element.id == event.postId)
                .likes
                .remove(event.user);
          } else if (event is AddLikeReplyToProfileUserEvent) {
            await postRepository.addLike(event.user, event.postId);
            successState.reply
                .where((element) => element.replyTo.id == event.postId)
                .forEach((element) {
              element.replyTo.likes.add(event.user);
            });
          } else if (event is RemoveLikeReplyToProfileUserEvent) {
            await postRepository.deleteLike(event.user, event.postId);

            successState.reply
                .where((element) => element.replyTo.id == event.postId)
                .forEach((element) {
              element.replyTo.likes.remove(event.user);
            });
          } else if (event is AddLikeMyReplyProfileUserEvent) {
            await postRepository.addLike(event.user, event.postId);
            successState.reply
                .where((element) => element.myReply.id == event.postId)
                .forEach((element) {
              element.myReply.likes.add(event.user);
            });
          } else if (event is RemoveLikeMyReplyProfileUserEvent) {
            await postRepository.deleteLike(event.user, event.postId);

            successState.reply
                .where((element) => element.myReply.id == event.postId)
                .forEach((element) {
              element.myReply.likes.remove(event.user);
            });
          }

           emit(ProfileUserSuccesState(
              successState.post,
              successState.userFollowers,
              successState.reply,
              successState.user));
        
        }
      }
    });
  }
}
