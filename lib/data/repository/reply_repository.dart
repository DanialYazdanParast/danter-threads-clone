import 'package:danter/data/datasource/reply_data_source.dart';
import 'package:danter/data/model/post.dart';

abstract class IReplyRepository {
  Future<List<PostEntity>> getReply(String postId);

  Future<String> sendPostReply(String userId, String text, String postid, image);
  
  Future<void> sendidReplyToPost(String idReply, String postId);
}

class ReplyRepository implements IReplyRepository {
  final IReplyDataSource dataSource;

  ReplyRepository(this.dataSource);

  @override
  Future<List<PostEntity>> getReply(String postId) {
    return dataSource.getReply(postId);
  }

  @override
  Future<String> sendPostReply(String userId, String text, String postid, image) {
    return dataSource.sendPostReply(userId, text, postid, image);
  }
  
  @override
  Future<void> sendidReplyToPost(String idReply, String postId) {
    return dataSource.sendidReplyToPost(idReply, postId);
  }
}
