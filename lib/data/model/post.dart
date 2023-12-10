import 'package:danter/data/model/user.dart';

class PostEntity {
  final String created;
  final String id;
  final String text;
  final User user;
  List<String> image;

  PostEntity.fromJson(Map<String, dynamic> json)
      : created = json['created'],
        id = json['id'],
        text = json['text'],
        user = User.fromJson(json['expand']['user']),
        image = List<String>.from(json["image"].map((x) => x));
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
