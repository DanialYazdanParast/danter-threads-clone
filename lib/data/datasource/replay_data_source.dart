import 'package:danter/data/model/reply.dart';
import 'package:danter/util/response_validator.dart';
import 'package:dio/dio.dart';

abstract class IReplyDataSource {
  Future<List<RplyEntity>> getReply(String postId);
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
}
