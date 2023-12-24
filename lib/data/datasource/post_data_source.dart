import 'package:danter/data/model/follow.dart';
import 'package:danter/data/model/like.dart';
import 'package:danter/data/model/post.dart';
import 'package:danter/data/model/replyphoto.dart';
import 'package:danter/data/model/user.dart';
import 'package:danter/util/response_validator.dart';
import 'package:dio/dio.dart';
import 'package:pocketbase/pocketbase.dart';

abstract class IPostDataSource {
  Future<List<PostEntity>> getPost(String userId);
  Future<List<PostEntity>> getPostProfile(String userId);
  Future<int> getPosttotalLike(String postId);
  Future<List<Replyphoto>> getPosttotalreplisePhoto(String postId);
  Future<int> getPosttotalreplise(String postId);
  Future<void> sendPost(String userId, String text, image);
  Future<int> getLikeuser(String postId, String userId);
  Future<void> addLike(String userId, String postid);
  Future<void> deleteLike(String userId, String postid);
  Future<List<LikeId>> getLikeid(String postId, String userId);
  Future<int> getTotalfollowers(String userId);
  Future<int> getTruefollowing(String myuserId, String userIdProfile);
  Future<void> addfollow(String myuserId, String userIdProfile);
  Future<List<FollowId>> getFollowid(String myuserId, String userIdProfile);
  Future<void> deleteFollow(String myuserId, String userIdProfile);
  Future<List<LikeUser>> getAllLikePost(String postId);
  Future<List<Followers>> geAllfollowers(String userId);
  Future<List<Following>> geAllfollowing(String userId);
  Future<void> deletePost(String postid);
  Future<User> sendNameAndBio(String userid, String name, String bio);
  Future<User> sendImagePorofile(String userid, image);
  Future<List<PostEntity>> getReply(String userId);
  Future<List<PostEntity>> getAllPost();

  Future<List<PostEntityAll>> getAllpostHome(String userId);
  Future<List<PostEntity>> getReplyPost(String postId);
  Future<List<PostEntityAll>> getAllReplyPost(String userId, String postId);

  Future<List<PostEntity>> getPostReply(String postId);
  Future<List<PostEntityAll>> getAllPostReply(String userId, String postId);
  Future<List<PostEntityAll>> getAllPostProfile(String userId);
  Future<List<PostEntityAll>> getAllReplyProfile(String userId);
  Future<List<PostReply>> getAllReply(String userId);
  Future<void> removeFollow(String myuserId, String userIdProfile);
}

class PostRemoteDataSource with HttpResponseValidat implements IPostDataSource {
  final Dio _dio;
  final pb = PocketBase('https://dan.chbk.run');
  // final String userId = AuthRepository.readid();
  PostRemoteDataSource(this._dio);
  @override
  Future<List<PostEntity>> getPost(String userId) async {
    Map<String, dynamic> qParams = {
      'filter': 'user !="$userId" && postid= "" ',
      'expand': 'user,replies.user ',
      'sort': '-created',
      'perPage': 500
    };
    var response = await _dio.get(
      'collections/post/records',
      queryParameters: qParams,
    );
    validatResponse(response);

    return response.data['items']
        .map<PostEntity>((jsonObject) => PostEntity.fromJson(jsonObject))
        .toList();
  }

  @override
  Future<int> getPosttotalLike(String postId) async {
    Map<String, dynamic> qParams = {
      'filter': 'post="$postId"',
    };
    var response = await _dio.get(
      'collections/like/records',
      queryParameters: qParams,
    );
    validatResponse(response);

    return response.data['totalItems'];
  }

  @override
  Future<List<Replyphoto>> getPosttotalreplisePhoto(String postId) async {
    Map<String, dynamic> qParams = {
      'filter': 'postid="$postId"',
      'expand': 'user',
    };
    var response = await _dio.get(
      'collections/post/records',
      queryParameters: qParams,
    );
    validatResponse(response);

    return response.data['items']
        .map<Replyphoto>((jsonObject) => Replyphoto.fromJson(jsonObject))
        .toList();
  }

  @override
  Future<int> getPosttotalreplise(String postId) async {
    Map<String, dynamic> qParams = {
      'filter': 'postid="$postId"',
    };
    var response = await _dio.get(
      'collections/post/records',
      queryParameters: qParams,
    );
    validatResponse(response);

    return response.data['totalItems'];
  }

  @override
  Future<List<PostEntity>> getPostProfile(String userId) async {
    Map<String, dynamic> qParams = {
      'filter': 'user ="$userId"&& postid= ""',
      'expand': 'user,replies.user ',
      'sort': '-created'
    };
    var response = await _dio.get(
      'collections/post/records',
      queryParameters: qParams,
    );
    validatResponse(response);

    return response.data['items']
        .map<PostEntity>((jsonObject) => PostEntity.fromJson(jsonObject))
        .toList();
  }

  @override
  Future<void> sendPost(String userId, String text, image) async {
    // String filename = image.path.split('/').last;

    //  List uploadList = [];
    //   for (File file in image) {
    //      await MultipartFile.fromFile(
    //       uploadList.add(file.path)
    //     );

    //   }

    //    for (File item in image)
    //  formData.files.addAll([
    //    MapEntry("image", await MultipartFile.fromFile(item.path)),
    //  ]);

    FormData formData = FormData.fromMap({
      "user": userId,
      "text": text,
      "image": image
          .map((item) => MultipartFile.fromFileSync(item.path,
              filename: item.path.split('/').last))
          .toList()
    });

    final response =
        await _dio.post('collections/post/records', data: formData);
    validatResponse(response);
  }

  @override
  Future<int> getLikeuser(String postId, String userId) async {
    Map<String, dynamic> qParams = {
      'filter': 'user="$userId"&&post="$postId"',
    };
    var response = await _dio.get(
      'collections/like/records',
      queryParameters: qParams,
    );
    validatResponse(response);

    return response.data['totalItems'];
  }

  @override
  Future<void> addLike(String userId, String postid) async {
   await _dio
        .patch('collections/post/records/$postid', data: {"likes+": userId});
   
  }

  @override
  Future<void> deleteLike(String userId, String postid) async {
     await _dio
        .patch('collections/post/records/$postid', data: {"likes-": userId});
 
  }

  @override
  Future<List<LikeId>> getLikeid(String postId, String userId) async {
    Map<String, dynamic> qParams = {
      'filter': 'user="$userId"&&post="$postId"',
    };
    var response = await _dio.get(
      'collections/like/records',
      queryParameters: qParams,
    );
    validatResponse(response);

    return response.data['items']
        .map<LikeId>((jsonObject) => LikeId.fromJson(jsonObject))
        .toList();
  }

  @override
  Future<int> getTotalfollowers(String userId) async {
    Map<String, dynamic> qParams = {
      'filter': 'fielduserfollower="$userId"',
    };
    var response = await _dio.get(
      'collections/follow/records',
      queryParameters: qParams,
    );
    validatResponse(response);

    return response.data['totalItems'];
  }

  @override
  Future<int> getTruefollowing(String myuserId, String userIdProfile) async {
    Map<String, dynamic> qParams = {
      'filter': 'userfollowing="$myuserId"&&fielduserfollower="$userIdProfile"',
    };
    var response = await _dio.get(
      'collections/follow/records',
      queryParameters: qParams,
    );
    validatResponse(response);

    return response.data['totalItems'];
  }

  @override
  Future<void> addfollow(String myuserId, String userIdProfile) async {
    final response = await _dio.patch(
        'collections/users/records/$userIdProfile',
        data: {"followers+": myuserId});
    validatResponse(response);
    final response2 = await _dio.patch('collections/users/records/$myuserId',
        data: {"following+": userIdProfile});

    validatResponse(response2);
  }

  @override
  Future<List<FollowId>> getFollowid(
      String myuserId, String userIdProfile) async {
    Map<String, dynamic> qParams = {
      'filter': 'userfollowing="$myuserId"&&fielduserfollower="$userIdProfile"',
    };
    var response = await _dio.get(
      'collections/follow/records',
      queryParameters: qParams,
    );
    validatResponse(response);

    return response.data['items']
        .map<FollowId>((jsonObject) => FollowId.fromJson(jsonObject))
        .toList();
  }

  @override
  Future<void> deleteFollow(String myuserId, String userIdProfile) async {
    final response = await _dio.patch(
        'collections/users/records/$userIdProfile',
        data: {"followers-": myuserId});
    validatResponse(response);
    final response2 = await _dio.patch('collections/users/records/$myuserId',
        data: {"following-": userIdProfile});

    validatResponse(response2);
  }

  @override
  Future<List<LikeUser>> getAllLikePost(String postId) async {
    Map<String, dynamic> qParams = {
      'filter': 'id="$postId"',
      'expand': 'likes',
    };
    var response = await _dio.get(
      'collections/post/records',
      queryParameters: qParams,
    );
    validatResponse(response);

    return response.data['items']
        .map<LikeUser>((jsonObject) => LikeUser.fromJson(jsonObject))
        .toList();
  }

  @override
  Future<List<Followers>> geAllfollowers(String userId) async {
    Map<String, dynamic> qParams = {
      'filter': 'id="$userId"',
      'expand': 'followers',
      'sort': '-created'
    };
    var response = await _dio.get(
      'collections/users/records',
      queryParameters: qParams,
    );
    validatResponse(response);

    return response.data['items']
        .map<Followers>((jsonObject) => Followers.fromJson(jsonObject))
        .toList();
  }

  @override
  Future<List<Following>> geAllfollowing(String userId) async {
    Map<String, dynamic> qParams = {
      'filter': 'id="$userId"',
      'expand': 'following',
      'sort': '-created'
    };
    var response = await _dio.get(
      'collections/users/records',
      queryParameters: qParams,
    );
    validatResponse(response);
    return response.data['items']
        .map<Following>((jsonObject) => Following.fromJson(jsonObject))
        .toList();
  }

  @override
  Future<void> deletePost(String postid) async {
    await pb.collection('post').delete(postid);
  }

  @override
  Future<User> sendNameAndBio(String userid, String name, String bio) async {
    final body = <String, dynamic>{
      "name": name,
      "bio": bio,
    };
    // final response =  await pb.collection('users').update(userid, body: body);

    var response = await _dio.patch(
      'collections/users/records/$userid',
      data: body,
    );

    return User.fromJson(response.data);
  }

  @override
  Future<User> sendImagePorofile(String userid, image) async {
    FormData formData = FormData.fromMap({
      "avatar": image == null ? null : await MultipartFile.fromFile(image.path),
    });

    var response = await _dio.patch(
      'collections/users/records/$userid',
      data: formData,
    );

    return User.fromJson(response.data);
  }

  @override
  Future<List<PostEntity>> getReply(String userId) async {
    Map<String, dynamic> qParams = {
      'filter': 'user ="$userId" && postid != "" ',
      'expand': 'user,replies.user ',
      'sort': '-created',
      'perPage': 500
    };
    var response = await _dio.get(
      'collections/post/records',
      queryParameters: qParams,
    );
    validatResponse(response);

    return response.data['items']
        .map<PostEntity>((jsonObject) => PostEntity.fromJson(jsonObject))
        .toList();
  }

  @override
  Future<List<PostEntity>> getAllPost() async {
    Map<String, dynamic> qParams = {
      'expand': 'user',
      'sort': '-created',
      'perPage': 500
    };
    var response = await _dio.get(
      'collections/post/records',
      queryParameters: qParams,
    );
    validatResponse(response);

    return response.data['items']
        .map<PostEntity>((jsonObject) => PostEntity.fromJson(jsonObject))
        .toList();
  }

  @override
  Future<List<PostEntityAll>> getAllpostHome(String userId) async {
    var getPostt = await getPost(userId);
    List<PostEntityAll> postEntityLike = [];

    for (var post in getPostt) {
      int totalLike = await getPosttotalLike(post.id);
      int likeuserpost = await getLikeuser(post.id, userId);
      int totalreplise = await getPosttotalreplise(post.id);
      List<Replyphoto> replyphoto = await getPosttotalreplisePhoto(post.id);
      List<LikeId> likeid = await getLikeid(post.id, userId);

      postEntityLike.add(PostEntityAll(
          post, totalLike, likeuserpost, totalreplise, replyphoto, likeid));
    }
    return postEntityLike;
  }

  @override
  Future<List<PostEntity>> getReplyPost(String postId) async {
    Map<String, dynamic> qParams = {
      'filter': 'postid ="$postId"',
      'expand': 'user,replies.user ',
      'sort': '-created'
    };
    var response = await _dio.get(
      'collections/post/records',
      queryParameters: qParams,
    );
    validatResponse(response);

    return response.data['items']
        .map<PostEntity>((jsonObject) => PostEntity.fromJson(jsonObject))
        .toList();
  }

  @override
  Future<List<PostEntityAll>> getAllReplyPost(
      String userId, String postId) async {
    var replyPost = await getReplyPost(postId);
    List<PostEntityAll> replyPostAll = [];

    for (var post in replyPost) {
      int totalLike = await getPosttotalLike(post.id);
      int likeuserpost = await getLikeuser(post.id, userId);
      int totalreplise = await getPosttotalreplise(post.id);
      List<Replyphoto> replyphoto = await getPosttotalreplisePhoto(post.id);
      List<LikeId> likeid = await getLikeid(post.id, userId);

      replyPostAll.add(PostEntityAll(
          post, totalLike, likeuserpost, totalreplise, replyphoto, likeid));
    }
    return replyPostAll;
  }

  @override
  Future<List<PostEntity>> getPostReply(String postId) async {
    Map<String, dynamic> qParams = {
      'filter': 'id ="$postId"',
      'expand': 'user,replies.user ',
    };
    var response = await _dio.get(
      'collections/post/records',
      queryParameters: qParams,
    );
    validatResponse(response);

    return response.data['items']
        .map<PostEntity>((jsonObject) => PostEntity.fromJson(jsonObject))
        .toList();
  }

  @override
  Future<List<PostEntityAll>> getAllPostReply(
      String userId, String postId) async {
    var postReply = await getPostReply(postId);
    List<PostEntityAll> replyPostAll = [];

    for (var post in postReply) {
      int totalLike = await getPosttotalLike(post.id);
      int likeuserpost = await getLikeuser(post.id, userId);
      int totalreplise = await getPosttotalreplise(post.id);
      List<Replyphoto> replyphoto = await getPosttotalreplisePhoto(post.id);
      List<LikeId> likeid = await getLikeid(post.id, userId);

      replyPostAll.add(PostEntityAll(
          post, totalLike, likeuserpost, totalreplise, replyphoto, likeid));
    }
    return replyPostAll;
  }

  @override
  Future<List<PostEntityAll>> getAllPostProfile(
    String userId,
  ) async {
    var postProfile = await getPostProfile(userId);
    List<PostEntityAll> postProfileAll = [];

    for (var post in postProfile) {
      int totalLike = await getPosttotalLike(post.id);
      int likeuserpost = await getLikeuser(post.id, userId);
      int totalreplise = await getPosttotalreplise(post.id);
      List<Replyphoto> replyphoto = await getPosttotalreplisePhoto(post.id);
      List<LikeId> likeid = await getLikeid(post.id, userId);

      postProfileAll.add(PostEntityAll(
          post, totalLike, likeuserpost, totalreplise, replyphoto, likeid));
    }
    return postProfileAll;
  }

  @override
  Future<List<PostReply>> getAllReply(
    String userId,
  ) async {
    var getReplyy = await getReply(
      userId,
    );

    List<PostReply> postReply = [];
    for (var replyy in getReplyy) {
      var replyTo = await getPostReply(replyy.postid);

      postReply.add(PostReply(replyy, replyTo[0]));
    }
    return postReply;
  }

  @override
  Future<List<PostEntityAll>> getAllReplyProfile(
    String userId,
  ) async {
    var getReplyy = await getReply(userId);
    List<PostEntityAll> allReplyProfile = [];

    for (var replyy in getReplyy) {
      int totalLike = await getPosttotalLike(replyy.id);
      int likeuserpost = await getLikeuser(replyy.id, userId);
      int totalreplise = await getPosttotalreplise(replyy.id);
      List<Replyphoto> replyphoto = await getPosttotalreplisePhoto(replyy.id);
      List<LikeId> likeid = await getLikeid(replyy.id, userId);
      allReplyProfile.add(PostEntityAll(
          replyy, totalLike, likeuserpost, totalreplise, replyphoto, likeid));
    }
    return allReplyProfile;
  }

  @override
  Future<void> removeFollow(String myuserId, String userIdProfile) async {
   
    final response = await _dio.patch(
        'collections/users/records/$myuserId',
        data: {"followers-": userIdProfile});
    validatResponse(response);
   
    final response2 = await _dio.patch(
        'collections/users/records/$userIdProfile',
        data: {"following-": myuserId});

    validatResponse(response2);
  }
}
