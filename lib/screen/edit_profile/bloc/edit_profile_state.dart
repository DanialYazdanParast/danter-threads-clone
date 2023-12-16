part of 'edit_profile_bloc.dart';

sealed class EditProfileState extends Equatable {
  const EditProfileState();

  @override
  List<Object> get props => [];
}

class EditProfileInitial extends EditProfileState {
 
}


class ChengSuccessEditProfileState extends EditProfileState {
  final String name;
  final String bio;
 const ChengSuccessEditProfileState({required this.name, required this.bio});

}


class SendSuccessEditProfileState extends EditProfileState {

}



class LodingEditProfileState extends EditProfileState {

}