import 'package:danter/data/model/user.dart';

class LikeId {

  final String id;

  LikeId({ required this.id});


   LikeId.fromJson(Map<String, dynamic> json)
      : 
        id = json['id'];
}


class LikeUser {


   final User user;

  LikeUser({ required this.user});


   LikeUser.fromJson(Map<String, dynamic> json)
      : 
        user =User.fromJson(json['expand']['user']) ;
}
