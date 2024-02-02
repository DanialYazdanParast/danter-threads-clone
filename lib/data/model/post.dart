import 'package:danter/data/model/user.dart';

class PostEntity {
  final String created;
  final String id;
  final String text;
  final User user;
  final List<String> image;
  final String postid;
  List<String> likes;
  final List<User> replies;
  final String postiduser;
  PostEntity(
      {required this.created,
      required this.id,
      required this.text,
      required this.user,
      required this.image,
      required this.postid,
      required this.likes,
      required this.replies,
      required this.postiduser});

  factory PostEntity.fromJson(Map<String, dynamic> json) {
    return PostEntity(
        created: json['created'],
        id: json['id'],
        text: json['text'],
        user: User.fromJson(json['expand']['user']),
        image: List<String>.from(json["image"].map((x) => x)),
        postid: json['postid'],
        likes: List<String>.from(json["likes"]),
        replies: List<String>.from(json["replies"]).isNotEmpty
            ? json['expand']['replies']
                .map<User>(
                    (jsonObject) => User.fromJson(jsonObject['expand']['user']))
                .toList()
            : [],
        postiduser: json['postid'] != ''
            ? json['expand']['postid']['expand']['user']['username']
            : json['postid']);
  }
}

class PostReply {
  PostEntity myReply;
  PostEntity replyTo;

  PostReply(this.myReply, this.replyTo);
}
