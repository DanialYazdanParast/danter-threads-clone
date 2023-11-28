import 'package:bloc/bloc.dart';
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
          final post = await postRepository.getPostProfile(event.user);
          emit(ProfileUserSuccesState(post));
        } catch (e) {
          emit(ProfileUserErrorState(
          exception: e is AppException ? e : AppException()));
        }
      }else if (event is ProfileUserRefreshEvent ) {
        try { 
          final post = await postRepository.getPostProfile(event.user);
          emit(ProfileUserSuccesState(post));
        } catch (e) {
          emit(ProfileUserErrorState(
          exception: e is AppException ? e : AppException()));
        }
      }
    });
  }
}
