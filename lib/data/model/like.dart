class LikeId {

  final String id;

  LikeId({ required this.id});


   LikeId.fromJson(Map<String, dynamic> json)
      : 
        id = json['id'];
}
