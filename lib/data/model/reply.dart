import 'package:danter/data/model/user.dart';

class RplyEntity {
  final String created;
  final String id;
  final String text;
  final User user;

  RplyEntity(this.created, this.id, this.text, this.user);

  RplyEntity.fromJson(Map<String, dynamic> json)
      : created = json['created'],
        id = json['id'],
        text = json['comment'],
        user =User.fromJson(json['expand']['user']) ;
}

