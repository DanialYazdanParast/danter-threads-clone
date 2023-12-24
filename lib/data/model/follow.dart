import 'package:danter/data/model/user.dart';

class FollowId {
  final String id;

  FollowId({required this.id});

  FollowId.fromJson(Map<String, dynamic> json) : id = json['id'];
}

class Followers {

 final List<User> user;

  Followers({ required this.user});

  Followers.fromJson(Map<String, dynamic> json)
      : 
        user = List<String>.from(json["followers"]).isNotEmpty
            ? json['expand']['followers']
                .map<User>((jsonObject) => User.fromJson(jsonObject))
                .toList()
            : [];
}

class Following {
  final List<User> user;

  Following({ required this.user});

  Following.fromJson(Map<String, dynamic> json)
    : user = List<String>.from(json["following"]).isNotEmpty
            ? json['expand']['following']
                .map<User>((jsonObject) => User.fromJson(jsonObject))
                .toList()
            : [];
}
