import 'package:danter/data/model/user.dart';

class PostEntity {
  final String created;
  final String id;
  final String text;
  final User user;

  PostEntity(this.created, this.id, this.text, this.user);

  PostEntity.fromJson(Map<String, dynamic> json)
      : created = json['created'],
        id = json['id'],
        text = json['text'],
        user =User.fromJson(json['expand']['user']) ;
}
