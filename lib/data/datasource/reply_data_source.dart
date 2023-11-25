import 'package:danter/data/model/reply.dart';
import 'package:danter/util/response_validator.dart';
import 'package:dio/dio.dart';

abstract class IReplyDataSource {
  Future<List<RplyEntity>> getReply(String postId);
   Future<int> getReplytotalLike(String replyId);
   Future<int> getReplytotalreplise(String replyId);
}

class ReplyRemoteDataSource
    with HttpResponseValidat
    implements IReplyDataSource {
  final Dio _dio;
  ReplyRemoteDataSource(this._dio);
  @override
  Future<List<RplyEntity>> getReply(String postId) async{
    Map<String, dynamic> qParams = {
      'filter': 'post ="$postId"',
      'expand': 'user',
      'sort': '-created'
    };
    var response = await _dio.get(
      'collections/reply/records',
      queryParameters: qParams,
    );
    validatResponse(response);

    return response.data['items']
        .map<RplyEntity>((jsonObject) => RplyEntity.fromJson(jsonObject))
        .toList();
  }
  
  @override
  Future<int> getReplytotalLike(String replyId)async {
    Map<String, dynamic> qParams = {
      'filter': 'reply="$replyId"',
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
      'filter': 'reply="$replyId"',
    };
    var response = await _dio.get(
      'collections/reply/records',
      queryParameters: qParams,
    );
    validatResponse(response);

    return response.data['totalItems'];
  }
  
 
}
