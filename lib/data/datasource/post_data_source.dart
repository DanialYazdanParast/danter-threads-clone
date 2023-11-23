import 'package:danter/data/model/post.dart';
import 'package:danter/data/model/replyphoto.dart';

import 'package:danter/util/response_validator.dart';
import 'package:dio/dio.dart';

abstract class IPostDataSource {
  Future<List<PostEntity>> getPost(String userId);
  Future<int> getPosttotalLike(String postId);
  // Future<int> getPosttotalreplise(String postId);
  Future<List<Replyphoto>> getPosttotalreplisePhoto(String postId);
  Future<int> getPosttotalreplise(String postId);
}

class PostRemoteDataSource with HttpResponseValidat implements IPostDataSource {
  final Dio _dio;

  // final String userId = AuthRepository.readid();
  PostRemoteDataSource(this._dio);
  @override
  Future<List<PostEntity>> getPost(String userId) async {
    Map<String, dynamic> qParams = {
      'filter': 'user !="$userId"',
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
      'filter': 'post="$postId"',
      'expand': 'user',
    };
    var response = await _dio.get(
      'collections/comment/records',
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
      'filter': 'post="$postId"',
    };
    var response = await _dio.get(
      'collections/comment/records',
      queryParameters: qParams,
    );
    validatResponse(response);

    return response.data['totalItems'];
  }
}
