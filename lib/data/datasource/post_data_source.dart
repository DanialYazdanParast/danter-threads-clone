import 'package:danter/data/model/follow.dart';
import 'package:danter/data/model/like.dart';
import 'package:danter/data/model/post.dart';
import 'package:danter/data/model/user.dart';
import 'package:danter/core/util/response_validator.dart';
import 'package:dio/dio.dart';
import 'package:pocketbase/pocketbase.dart';

abstract class IPostDataSource {
  Future<List<PostEntity>> getPost(String userId);
  Future<List<PostEntity>> getPostProfile(String userId);
  Future<void> sendPost(String userId, String text, image);
  Future<void> addLike(String userId, String postid);
  Future<void> deleteLike(String userId, String postid);
  Future<void> addfollow(String myuserId, String userIdProfile);
  Future<void> deleteFollow(String myuserId, String userIdProfile);
  Future<List<LikeUser>> getAllLikePost(String postId);
  Future<List<Followers>> geAllfollowers(String userId);
  Future<List<Following>> geAllfollowing(String userId);
  Future<void> deletePost(String postid);
  Future<User> sendNameAndBio(String userid, String name, String bio);
  Future<User> sendImagePorofile(String userid, image);
  Future<List<PostEntity>> getReply(String userId);
  Future<List<PostEntity>> getReplyPost(String postId);
  Future<List<PostEntity>> getPostReply(String postId);
  Future<List<PostReply>> getAllReply(String userId);
  Future<void> removeFollow(String myuserId, String userIdProfile);
  Future<User> getUser(String userId);
  Future<List<User>> getAllUser(String userId);
  Future<List<User>> getSearchUser(String keyuserName, String userId);
}

class PostRemoteDataSource with HttpResponseValidat implements IPostDataSource {
  final Dio _dio;
  final pb = PocketBase('https://dan.chbk.run');
  // final String userId = AuthRepository.readid();
  PostRemoteDataSource(this._dio);
  @override
  Future<List<PostEntity>> getPost(String userId) async {
    Map<String, dynamic> qParams = {
      'filter': 'user !="$userId" && category ="ykbdovmvv3qf66l"',
      'expand': 'user,replies.user,postid.user',
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
  Future<List<PostEntity>> getPostProfile(String userId) async {
    Map<String, dynamic> qParams = {
      'filter': 'user ="$userId" && category ="ykbdovmvv3qf66l"',
      'expand': 'user,replies.user,postid.user',
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
      "category": 'ykbdovmvv3qf66l',
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
      'perPage': 500
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
      'sort': '-created',
      'perPage': 500
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
      'sort': '-created',
      'perPage': 500
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
      'filter':
          'user ="$userId" && postid != "" && category ="oevvz5ic1r1garf"',
      'expand': 'user,replies.user,postid.user',
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
  Future<List<PostEntity>> getReplyPost(String postId) async {
    Map<String, dynamic> qParams = {
      'filter': 'postid ="$postId"',
      'expand': 'user,replies.user,postid.user',
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
  Future<List<PostEntity>> getPostReply(String postId) async {
    Map<String, dynamic> qParams = {
      'filter': 'id ="$postId"',
      'expand': 'user,replies.user,postid.user',
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
  Future<void> removeFollow(String myuserId, String userIdProfile) async {
    final response = await _dio.patch('collections/users/records/$myuserId',
        data: {"followers-": userIdProfile});
    validatResponse(response);

    final response2 = await _dio.patch(
        'collections/users/records/$userIdProfile',
        data: {"following-": myuserId});

    validatResponse(response2);
  }

  @override
  Future<User> getUser(String userId) async {
    final response = await _dio.get('collections/users/records/$userId');
    return User.fromJson(response.data);
  }

  @override
  Future<List<User>> getAllUser(String userId) async {
    Map<String, dynamic> qParams = {
      'filter': 'id !="$userId"',
      'sort': '-created',
      'perPage': 500
    };
    var response = await _dio.get(
      'collections/users/records',
      queryParameters: qParams,
    );
    validatResponse(response);
    return response.data['items']
        .map<User>((jsonObject) => User.fromJson(jsonObject))
        .toList();
  }

  @override
  Future<List<User>> getSearchUser(String keyuserName, String userId) async {
    Map<String, dynamic> qParams = {
      'filter': 'username~"$keyuserName" && id !="$userId"',
      'sort': '-created',
      'perPage': 500
    };
    var response = await _dio.get(
      'collections/users/records',
      queryParameters: qParams,
    );
    validatResponse(response);
    return response.data['items']
        .map<User>((jsonObject) => User.fromJson(jsonObject))
        .toList();
  }
}
