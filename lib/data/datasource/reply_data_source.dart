import 'package:danter/data/model/post.dart';

import 'package:danter/util/response_validator.dart';
import 'package:dio/dio.dart';

abstract class IReplyDataSource {
  Future<List<PostEntity>> getReply(String postId);
   Future<int> getReplytotalLike(String replyId);
   Future<int> getReplytotalreplise(String replyId);
    Future<void> sendPostReply(String userId ,String text ,String postid);
 }

class ReplyRemoteDataSource
    with HttpResponseValidat
    implements IReplyDataSource {
  final Dio _dio;
  ReplyRemoteDataSource(this._dio);
  @override
  Future<List<PostEntity>> getReply(String postId) async{
    Map<String, dynamic> qParams = {
      'filter': 'postid ="$postId"',
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
  Future<int> getReplytotalLike(String replyId)async {
    Map<String, dynamic> qParams = {
      'filter': 'post="$replyId"',
    };
    var response = await _dio.get(
      'collections/like/records',
      queryParameters: qParams,
    );
    validatResponse(response);

    return response.data['totalItems'];
  }
  
  @override
  Future<int> getReplytotalreplise(String replyId) async{
        Map<String, dynamic> qParams = {
      'filter': 'postid="$replyId"',
    };
    var response = await _dio.get(
      'collections/post/records',
      queryParameters: qParams,
    );
    validatResponse(response);

    return response.data['totalItems'];
  }
  
  @override
  Future<void> sendPostReply(String userId, String text, String postid) async{
    
    final response = await _dio.post('collections/post/records',
        data: {"user": userId, "text": text , "postid": postid  });
    validatResponse(response);
  }
  
 
}
