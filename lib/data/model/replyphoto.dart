import 'package:danter/data/model/user.dart';

class Replyphoto {

  final User user;

  Replyphoto( this.user,);

  Replyphoto.fromJson(Map<String, dynamic> json)
      : 
        user = User.fromJson(json['expand']['user']);
}
