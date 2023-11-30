import 'package:danter/data/model/user.dart';

class FollowId {
  final String id;

  FollowId({required this.id});

  FollowId.fromJson(Map<String, dynamic> json) : id = json['id'];
}

class Followers {
  final String id;
  final User user;

  Followers({required this.id, required this.user});

  Followers.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = User.fromJson(json['expand']['userfollowing']);
}

class Following {
  final String id;
  final User user;

  Following({required this.id, required this.user});

  Following.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        user = User.fromJson(json['expand']['fielduserfollower']);
}
