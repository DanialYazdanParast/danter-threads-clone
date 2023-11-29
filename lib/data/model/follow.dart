class FollowId {

  final String id;

  FollowId({ required this.id});


   FollowId.fromJson(Map<String, dynamic> json)
      : 
        id = json['id'];
}
