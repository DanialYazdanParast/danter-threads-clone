import 'package:danter/data/datasource/replay_data_source.dart';
import 'package:danter/data/model/reply.dart';

abstract class IReplyRepository {
  Future<List<RplyEntity>> getReply(String postId);
}

class ReplyRepository implements IReplyRepository {
  final IReplyDataSource dataSource;

  ReplyRepository(this.dataSource);

  @override
  Future<List<RplyEntity>> getReply(String postId) {
    return dataSource.getReply(postId);
  }
}
