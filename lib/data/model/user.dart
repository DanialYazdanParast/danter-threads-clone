import 'package:danter/core/constants/variable_onstants.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  final String username;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String id;
  @HiveField(3)
  final String? bio;
  @HiveField(4)
  final String collectionId;
  @HiveField(5)
  final String avatar;
  @HiveField(6)
  final String avatarchek;
  @HiveField(7)
  final List<String> followers;
  @HiveField(8)
  final List<String> following;
  @HiveField(9)
  final bool tik;
  @HiveField(10)
  final bool online;

  User(
    this.followers,
    this.following, {
    required this.avatarchek,
    required this.username,
    required this.name,
    required this.id,
    required this.bio,
    required this.collectionId,
    required this.avatar,
    required this.tik,
    required this.online,
  });

  User.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        name = json['name'] == null ? json['username'] : json['name'],
        id = json['id'],
        bio = json['bio'],
        collectionId = json['collectionId'],
        avatar =
            '${VariableConstants.domain}/api/files/${json['collectionName']}/${json['id']}/${json['avatar']}',
        avatarchek = json['avatar'],
        followers = List<String>.from(json["followers"]),
        following = List<String>.from(json["following"]),
        tik = json['tik'],
        online = json['online'];
}
