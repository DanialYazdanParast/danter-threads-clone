import 'package:danter/data/model/user.dart';

class MessagesList {
  String text;
  final String id;
  final User usersend;
  final User usersseen;
  final String roomid;
  final String created;

  MessagesList({
    required this.text,
    required this.id,
    required this.usersend,
    required this.usersseen,
    required this.roomid,
    required this.created,
  });

  factory MessagesList.fromMapson(Map<String, dynamic> jsonObject) {
    return MessagesList(
      text: jsonObject['text'],
      id: jsonObject['id'],
      usersend: User.fromJson(jsonObject['expand']['usersend']),
      usersseen: User.fromJson(jsonObject['expand']['usersseen']),
      roomid: jsonObject['roomid'],
      created: jsonObject['created'],
    );
  }
}
