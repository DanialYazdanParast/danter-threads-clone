import 'package:bloc/bloc.dart';
import 'package:danter/data/repository/post_repository.dart';

import 'package:equatable/equatable.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final IPostRepository postRepository;
  EditProfileBloc(this.postRepository) : super(EditProfileInitial()) {
    on<EditProfileEvent>((event, emit) async {
      if (event is ChengEditProfileEvent) {
        emit(EditProfileInitial());
        emit(ChengSuccessEditProfileState(name: event.name, bio: event.bio));
      } else if (event is SendBioAndNameEditProfileEvent) {
         emit(LodingEditProfileState());
      await  postRepository.sendNameAndBio(event.userid, event.name, event.bio);
       if(event.image != null){
      await     postRepository.sendImagePorofile(event.userid, event.image,);
       }   
        emit(SendSuccessEditProfileState());
      }
    });
  }
}
