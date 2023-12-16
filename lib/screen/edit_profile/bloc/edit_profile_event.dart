part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object> get props => [];
}

class ChengEditProfileEvent extends EditProfileEvent {
  final String name;
  final String bio;
 const ChengEditProfileEvent({required this.name, required this.bio});

}

class SendBioAndNameEditProfileEvent  extends EditProfileEvent{
final String userid;
final String name;
  final String bio;
    final  image;
 const SendBioAndNameEditProfileEvent( {required this.userid, required this.name, required this.bio, required this.image});

}


class SendImageEditProfileEvent  extends EditProfileEvent{
final String userid;
  final  image;
 const SendImageEditProfileEvent( {required this.userid, required this.image, });

}