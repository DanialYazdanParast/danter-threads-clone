import 'package:bloc/bloc.dart';
import 'package:danter/data/model/follow.dart';
import 'package:danter/data/model/post.dart';
import 'package:danter/data/repository/post_repository.dart';
import 'package:danter/util/exceptions.dart';
import 'package:equatable/equatable.dart';

part 'profile_user_event.dart';
part 'profile_user_state.dart';

class ProfileUserBloc extends Bloc<ProfileUserEvent, ProfileUserState> {
      final IPostRepository postRepository;
  ProfileUserBloc(this.postRepository) : super(ProfileUserLodingState()) {
    on<ProfileUserEvent>((event, emit) async{
        if (event is ProfileUserStartedEvent ) {
        try {
          emit(ProfileUserLodingState());
          final post = await postRepository.getAllPostProfile(event.userIdProfile);
                final totalfollowers =
              await postRepository.getTotalfollowers(event.userIdProfile);

               final truefollowing =
              await postRepository.getTruefollowing(event.myuserId,event.userIdProfile);
          final followid =
              await postRepository.getFollowid(event.myuserId,event.userIdProfile);
              final follwers = await postRepository.geAllfollowers(event.userIdProfile);
          emit(ProfileUserSuccesState(post,totalfollowers ,truefollowing ,followid ,follwers));
        } catch (e) {
          emit(ProfileUserErrorState(
          exception: e is AppException ? e : AppException()));
        }
      }else if (event is ProfileUserRefreshEvent ) {
        try { 
          final post = await postRepository.getAllPostProfile(event.userIdProfile);
            final totalfollowers =
              await postRepository.getTotalfollowers(event.userIdProfile);
          final truefollowing =
              await postRepository.getTruefollowing(event.myuserId,event.userIdProfile);
              final followid =
              await postRepository.getFollowid(event.myuserId,event.userIdProfile);
                final follwers = await postRepository.geAllfollowers(event.userIdProfile);
          emit(ProfileUserSuccesState(post,totalfollowers ,truefollowing ,followid ,follwers));
        } catch (e) {
          emit(ProfileUserErrorState(
          exception: e is AppException ? e : AppException()));
        }
      }else if (event is ProfileUserAddfollowhEvent ) {
        try { 
              await postRepository.addfollow(event.myuserId,event.userIdProfile);
         final post = await postRepository.getAllPostProfile(event.userIdProfile);
            final totalfollowers =
              await postRepository.getTotalfollowers(event.userIdProfile);
          final truefollowing =
              await postRepository.getTruefollowing(event.myuserId,event.userIdProfile);
          final followid =
              await postRepository.getFollowid(event.myuserId,event.userIdProfile);
                  final follwers = await postRepository.geAllfollowers(event.userIdProfile);
          emit(ProfileUserSuccesState(post,totalfollowers ,truefollowing ,followid ,follwers));
        } catch (e) {
          emit(ProfileUserErrorState(
          exception: e is AppException ? e : AppException()));
        }
      }else if (event is ProfileUserDelletfollowhEvent ) {
        try { 
          
       //       await postRepository.deleteFollow(event.followId);
        final post = await postRepository.getAllPostProfile(event.userIdProfile);
            final totalfollowers =
              await postRepository.getTotalfollowers(event.userIdProfile);
          final truefollowing =
              await postRepository.getTruefollowing(event.myuserId,event.userIdProfile);
          final followid =
              await postRepository.getFollowid(event.myuserId,event.userIdProfile);
                 final follwers = await postRepository.geAllfollowers(event.userIdProfile);
          emit(ProfileUserSuccesState(post,totalfollowers ,truefollowing ,followid ,follwers));
        } catch (e) {
          emit(ProfileUserErrorState(
          exception: e is AppException ? e : AppException()));
        }
      }
    });
  }
}
