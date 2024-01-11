import 'package:danter/data/model/user.dart';

class LikeUser {
  final List<User> user;

  LikeUser({required this.user});

  LikeUser.fromJson(Map<String, dynamic> json)
      : user = List<String>.from(json["likes"]).isNotEmpty
            ? json['expand']['likes']
                .map<User>((jsonObject) => User.fromJson(jsonObject))
                .toList()
            : [];
}
    //    User.fromJson(json['expand']['likes']) ;

