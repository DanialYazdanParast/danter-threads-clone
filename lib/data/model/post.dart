import 'package:danter/data/model/like.dart';
import 'package:danter/data/model/replyphoto.dart';
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
  PostEntity(
      {required this.created,
      required this.id,
      required this.text,
      required this.user,
      required this.image,
      required this.postid,
      required this.likes,
      required this.replies});

  factory PostEntity.fromJson(Map<String, dynamic> json) {
  
    return PostEntity(
        created: json['created'],
        id: json['id'],
        text: json['text'],
        user: User.fromJson(json['expand']['user']),
        image: List<String>.from(json["image"].map((x) => x)),
        postid: json['postid'] ,
        likes: List<String>.from(json["likes"]),
        replies:List<String>.from(json["replies"]).isNotEmpty? json['expand']['replies'].map<User>((jsonObject) => User.fromJson(jsonObject['expand']['user']))
        .toList():[]);
  }
}


//  replies:List<String>.from(json["replies"]).isNotEmpty? json['expand']['replies'].map<PostEntity>((jsonObject) => PostEntity.fromJson(jsonObject))
//         .toList():[]);

class PostEntityAll {
  PostEntity post;
  int totalLike;
  int likeuserpost;
  int totalreply;
  List<Replyphoto> replyphoto;
  List<LikeId> likeid;

  PostEntityAll(this.post, this.totalLike, this.likeuserpost, this.totalreply,
      this.replyphoto, this.likeid);
}

class PostReply {
  PostEntity myReply;
  PostEntity replyTo;

  PostReply(this.myReply, this.replyTo);
}





// return response.data['items']
//         .map<Replyphoto>((jsonObject) => Replyphoto.fromJson(jsonObject))
//         .toList();



// class ImageEntity {
//   String image;
//   ImageEntity.fromJson(Map<String, dynamic> json)
//       : image ='https://dan.chbk.run/api/files/${json['collectionName']}/${json['id']}/${json['image']}';
//  static List<ImageEntity> parsejsonArray(List<dynamic> jsonArry) {
//     final List<ImageEntity> imageEntity = [];
//     jsonArry.forEach((element) {
//       imageEntity.add( ImageEntity.fromJson(element));
//     });
//     return imageEntity;
//   }
// }





// class MainListItem {
//   String name;
//   List<SubListItem> subList;

//   MainListItem({required this.name, required this.subList});

//   factory MainListItem.fromJson(Map<String, dynamic> json) {
//     var subListJson = json['subList'] as List;
//     List<SubListItem> subListItems = subListJson.map((subJson) => SubListItem.fromJson(subJson)).toList();

//     return MainListItem(
//       name: json['name'],
//       subList: subListItems,
//     );
//   }
// }

// class SubListItem {
//   String subName;

//   SubListItem({required this.subName});

//   factory SubListItem.fromJson(Map<String, dynamic> json) {
//     return SubListItem(
//       subName: json['subName'],
//     );
//   }
// }






// import 'package:danter/data/model/user.dart';

// class PostEntity {
//   final String created;
//   final String id;
//   final String text;
//   final User user;
//   final String image;
//    imagechek =json['image'];

//   PostEntity(this.created, this.id, this.text, this.user, this.image, this.imagechek);

//   PostEntity.fromJson(Map<String, dynamic> json)
//       : created = json['created'],
//         id = json['id'],
//         text = json['text'],
//         user =User.fromJson(json['expand']['user']) ,
//         image ='https://dan.chbk.run/api/files/${json['collectionName']}/${json['id']}/${json['image']}' ,
//         imagechek =json['image'];
// }
