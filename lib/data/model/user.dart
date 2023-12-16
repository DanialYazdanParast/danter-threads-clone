
class User {
  
  final String username;
  final String? name;
  final String id;
  final String? bio;
  final String collectionId;
  final String avatar;
  final String avatarchek;
 

  User({ required this.avatarchek,required this.username,required this.name,required this.id,required this.bio,
     required this.collectionId,required this.avatar,});

  User.fromJson(Map<String, dynamic> json)
      : 
        username = json['username'],
        name = json['name'] == null?json['username']:json['name'],
        id = json['id'] ,
        bio = json['bio'],
        collectionId = json['collectionId'],
        avatar =
            'https://dan.chbk.run/api/files/${json['collectionName']}/${json['id']}/${json['avatar']}',
             avatarchek = json['avatar'];
      
}




