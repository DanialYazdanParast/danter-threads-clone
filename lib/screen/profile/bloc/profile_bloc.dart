import 'package:bloc/bloc.dart';
import 'package:danter/data/model/follow.dart';
import 'package:danter/data/model/post.dart';
import 'package:danter/data/repository/post_repository.dart';
import 'package:danter/util/exceptions.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final IPostRepository postRepository;
  ProfileBloc(this.postRepository) : super(ProfileLodingState()) {
    on<ProfileEvent>((event, emit) async {
      if (event is ProfileStartedEvent) {
        try {
          emit(ProfileLodingState());
          final post = await postRepository.getPostProfile(event.user);
          final follwers = await postRepository.geAllfollowers(event.user);
          final reply = await postRepository.getAllReply(event.user);
          emit(ProfileSuccesState(post, follwers, reply));
        } catch (e) {
          emit(ProfileErrorState(
              exception: e is AppException ? e : AppException()));
        }
      } else if (event is ProfileRefreshEvent) {
        try {
          final post = await postRepository.getPostProfile(event.user);
          final follwers = await postRepository.geAllfollowers(event.user);
          final reply = await postRepository.getAllReply(event.user);
          emit(ProfileSuccesState(post, follwers, reply));
        } catch (e) {
          emit(ProfileErrorState(
              exception: e is AppException ? e : AppException()));
        }
      } else if (event is ProfiledeletPostEvent) {
        try {
          await postRepository.deletePost(event.postid);
          final post = await postRepository.getPostProfile(event.user);
          final follwers = await postRepository.geAllfollowers(event.user);
          final reply = await postRepository.getAllReply(event.user);
          emit(ProfileSuccesState(post, follwers, reply));
        } catch (e) {
          emit(ProfileErrorState(
              exception: e is AppException ? e : AppException()));
        }
      } else if (event is AddLikeProfileEvent ||
          event is RemoveLikeProfileEvent ||
          event is AddLikeReplyToProfileEvent ||
          event is RemoveLikeReplyToProfileEvent ||
          event is AddLikeMyReplyProfileEvent ||
          event is RemoveLikeMyReplyProfileEvent) {
        if (state is ProfileSuccesState) {
          final successState = (state as ProfileSuccesState);
          if (event is AddLikeProfileEvent) {
            await postRepository.addLike(event.user, event.postId);
            successState.post
                .firstWhere((element) => element.id == event.postId)
                .likes
                .add(event.user);
          } else if (event is RemoveLikeProfileEvent) {
            await postRepository.deleteLike(event.user, event.postId);

            successState.post
                .firstWhere((element) => element.id == event.postId)
                .likes
                .remove(event.user);
          } else if (event is AddLikeReplyToProfileEvent) {
            await postRepository.addLike(event.user, event.postId);
            successState.reply
                .where((element) => element.replyTo.id == event.postId)
                .forEach((element) {
              element.replyTo.likes.add(event.user);
            });
          } else if (event is RemoveLikeReplyToProfileEvent) {
            await postRepository.deleteLike(event.user, event.postId);

            successState.reply
                .where((element) => element.replyTo.id == event.postId)
                .forEach((element) {
              element.replyTo.likes.remove(event.user);
            });
          } else if (event is AddLikeMyReplyProfileEvent) {
            await postRepository.addLike(event.user, event.postId);
            successState.reply
                .where((element) => element.myReply.id == event.postId)
                .forEach((element) {
              element.myReply.likes.add(event.user);
            });
          } else if (event is RemoveLikeMyReplyProfileEvent) {
            await postRepository.deleteLike(event.user, event.postId);

            successState.reply
                .where((element) => element.myReply.id == event.postId)
                .forEach((element) {
              element.myReply.likes.remove(event.user);
            });
          }

          emit(ProfileSuccesState(successState.post, successState.userFollowers,
              successState.reply));
        }
      }
    });
  }
}
