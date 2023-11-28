
import 'package:danter/data/model/like.dart';
import 'package:danter/data/model/post.dart';
import 'package:danter/data/model/replyphoto.dart';

import 'package:danter/util/response_validator.dart';
import 'package:dio/dio.dart';
import 'package:pocketbase/pocketbase.dart';
abstract class IPostDataSource {
  Future<List<PostEntity>> getPost(String userId);
  Future<List<PostEntity>> getPostProfile(String userId);
  Future<int> getPosttotalLike(String postId);
  Future<List<Replyphoto>> getPosttotalreplisePhoto(String postId);
  Future<int> getPosttotalreplise(String postId);
  Future<void> sendPost(String userId ,String text);
  Future<int> getLikeuser(String postId ,String userId);
  Future<void> addLike(String userId ,String postid);
  Future<void> deleteLike(String likeid);
 Future<List<LikeId>> getLikeid(String postId, String userId );
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
      'expand': 'user',
      'sort': '-created',
      

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
  Future<List<PostEntity>> getPostProfile(String userId) async{
   Map<String, dynamic> qParams = {
      'filter': 'user ="$userId"&& postid= ""',
      'expand': 'user',
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
  Future<void> sendPost(String userId ,String text) async{
    
    final response = await _dio.post('collections/post/records',
        data: {"user": userId, "text": text });
    validatResponse(response);
  }
  
  @override
  Future<int> getLikeuser(String postId, String userId) async{
    Map<String, dynamic> qParams = {
      'filter': 'user="$userId"&&post="$postId"',
    };
    var response = await _dio.get(
      'collections/like/records',
      queryParameters: qParams,
    );
    validatResponse(response);

    return   response.data['totalItems'];
  }
  
  @override
  Future<void> addLike(String userId, String postid)async {
    
    final response = await _dio.post('collections/like/records',
        data: {"user": userId, "post": postid });
    validatResponse(response);
  }
  
  @override
  Future<void> deleteLike(String likeid) async{

    await pb.collection('like').delete(likeid);

  }
  
  @override
  Future<List<LikeId>> getLikeid(String postId, String userId) async{
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
}
