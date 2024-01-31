class AuthInfo {
  final String username;
  final String name;
  final String id;
  final String bio;
  final String collectionId;
  final String avatar;
  final String avatarchek;
  final String token;
  final bool tik;

  AuthInfo({
    required this.avatarchek,
    required this.username,
    required this.name,
    required this.id,
    required this.bio,
    required this.collectionId,
    required this.avatar,
    this.token = '',
    required this.tik,
  });

  AuthInfo.fromJson(Map<String, dynamic> json)
      : username = json['record']['username'],
        name = json['record']['name'] == null
            ? json['record']['username']
            : json['record']['name'],
        id = json['record']['id'],
        bio = json['record']['bio'],
        collectionId = json['record']['collectionId'],
        avatar =
            'https://dan.chbk.run/api/files/${json['record']['collectionName']}/${json['record']['id']}/${json['record']['avatar']}',
        avatarchek = json['record']['avatar'],
        token = json['token'],
        tik = json['record']['tik'];
}
