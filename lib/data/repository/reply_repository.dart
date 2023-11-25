import 'package:danter/data/datasource/reply_data_source.dart';
import 'package:danter/data/model/reply.dart';

abstract class IReplyRepository {
  Future<List<RplyEntity>> getReply(String postId);
  Future<int> getReplytotalLike(String replyId);
  Future<int> getReplytotalreplise(String replyId);
}

class ReplyRepository implements IReplyRepository {
  final IReplyDataSource dataSource;

  ReplyRepository(this.dataSource);

  @override
  Future<List<RplyEntity>> getReply(String postId) {
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
}
