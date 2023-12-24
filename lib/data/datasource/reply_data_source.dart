import 'package:danter/data/model/post.dart';

import 'package:danter/util/response_validator.dart';
import 'package:dio/dio.dart';

abstract class IReplyDataSource {
  Future<List<PostEntity>> getReply(String postId);

  Future<String> sendPostReply(
      String userId, String text, String postid, image);

  Future<void> sendidReplyToPost(String idReply, String postId);
}

class ReplyRemoteDataSource
    with HttpResponseValidat
    implements IReplyDataSource {
  final Dio _dio;
  ReplyRemoteDataSource(this._dio);
  @override
  Future<List<PostEntity>> getReply(String postId) async {
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
  Future<String> sendPostReply(
      String userId, String text, String postid, image) async {
    FormData formData = FormData.fromMap({
      "postid": postid,
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
    return response.data["id"];
  }

  @override
  Future<void> sendidReplyToPost(String idReply, String postId) async {
    final response = await _dio
        .patch('collections/post/records/$postId', data: {"replies+": idReply});
    validatResponse(response);
  }
}
