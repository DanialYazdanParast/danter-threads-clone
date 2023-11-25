import 'package:danter/data/datasource/reply_data_source.dart';
import 'package:danter/data/model/post.dart';

abstract class IReplyRepository {
  Future<List<PostEntity>> getReply(String postId);
  Future<int> getReplytotalLike(String replyId);
  Future<int> getReplytotalreplise(String replyId);
  Future<void> sendPostReply(String userId, String text, String postid);
}

class ReplyRepository implements IReplyRepository {
  final IReplyDataSource dataSource;

  ReplyRepository(this.dataSource);

  @override
  Future<List<PostEntity>> getReply(String postId) {
    return dataSource.getReply(postId);
  }

  @override
  Future<int> getReplytotalLike(String replyId) {
    return dataSource.getReplytotalLike(replyId);
  }

  @override
  Future<int> getReplytotalreplise(String replyId) {
    return dataSource.getReplytotalreplise(replyId);
  }

  @override
  Future<void> sendPostReply(String userId, String text, String postid) {
    return dataSource.sendPostReply(userId, text, postid);
  }
}
