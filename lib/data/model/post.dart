import 'package:danter/data/model/user.dart';

class PostEntity {
  final String created;
  final String id;
  final String text;
  final User user;
  final String image;
  final String imagechek;

  PostEntity(this.created, this.id, this.text, this.user, this.image, this.imagechek);

  PostEntity.fromJson(Map<String, dynamic> json)
      : created = json['created'],
        id = json['id'],
        text = json['text'],
        user =User.fromJson(json['expand']['user']) ,
        image ='https://dan.chbk.run/api/files/${json['collectionName']}/${json['id']}/${json['image']}' ,
        imagechek =json['image'];
}
