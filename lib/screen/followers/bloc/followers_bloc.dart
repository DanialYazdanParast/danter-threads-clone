import 'package:bloc/bloc.dart';
import 'package:danter/data/model/follow.dart';

import 'package:danter/data/repository/post_repository.dart';
import 'package:danter/util/exceptions.dart';
import 'package:equatable/equatable.dart';

part 'followers_event.dart';
part 'followers_state.dart';

class FollowersBloc extends Bloc<FollowersEvent, FollowersState> {
    final IPostRepository postRepository;
  FollowersBloc(this.postRepository) : super(FollowersLodingState()) {
    on<FollowersEvent>((event, emit) async{
       if (event is FollowersStartedEvent ) {
        try {
          emit(FollowersLodingState());
          final follwers = await postRepository.geAllfollowers(event.user);
          final follwing = await postRepository.geAllfollowing(event.user);
          emit(FollowersSuccesState(follwers ,follwing));
        } catch (e) {
          emit(FollowersErrorState(
              exception: e is AppException ? e : AppException()));
        }
      }
     
    });
  }
}
