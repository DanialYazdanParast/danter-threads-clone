import 'package:bloc/bloc.dart';
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
          final totalfollowers =
              await postRepository.getTotalfollowers(event.user);
          emit(ProfileSuccesState(post ,totalfollowers));
        } catch (e) {
          emit(ProfileErrorState(
              exception: e is AppException ? e : AppException()));
        }
      } else if (event is ProfileRefreshEvent) {
        try {
          final post = await postRepository.getPostProfile(event.user);
          final totalfollowers =
              await postRepository.getTotalfollowers(event.user);
          emit(ProfileSuccesState(post ,totalfollowers));
        } catch (e) {
          emit(ProfileErrorState(
              exception: e is AppException ? e : AppException()));
        }
      }
    });
  }
}
