import 'package:danter/data/datasource/post_data_source.dart';
import 'package:danter/data/model/like.dart';
import 'package:danter/data/model/post.dart';
import 'package:danter/data/model/replyphoto.dart';

abstract class IPostRepository {
  Future<List<PostEntity>> getPost(String userId);
  Future<List<PostEntity>> getPostProfile(String userId);
  Future<int> getPosttotalLike(String postId);
  Future<int> getPosttotalreplise(String postId);
  Future<List<Replyphoto>> getPosttotalreplisePhoto(String postId);
  Future<void> sendPost(String userId, String text);
  Future<int> getLikeuser(String postId, String userId);
  Future<void> addLike(String userId, String postid);
  Future<void> deleteLike(String likeid);
  Future<List<LikeId>> getLikeid(String postId);
}

class PostRepository implements IPostRepository {
  final IPostDataSource dataSource;
  PostRepository(this.dataSource);
  @override
  Future<List<PostEntity>> getPost(String userId) {
    return dataSource.getPost(userId);
  }

  @override
  Future<int> getPosttotalLike(String postId) {
    return dataSource.getPosttotalLike(postId);
  }

  @override
  Future<int> getPosttotalreplise(String postId) {
    return dataSource.getPosttotalreplise(postId);
  }

  @override
  Future<List<Replyphoto>> getPosttotalreplisePhoto(String postId) {
    return dataSource.getPosttotalreplisePhoto(postId);
  }

  @override
  Future<List<PostEntity>> getPostProfile(String userId) {
    return dataSource.getPostProfile(userId);
  }

  @override
  Future<void> sendPost(String userId, String text) {
    return dataSource.sendPost(userId, text);
  }

  @override
  Future<int> getLikeuser(String postId, String userId) {
    return dataSource.getLikeuser(postId, userId);
  }

  @override
  Future<void> addLike(String userId, String postid) {
    return dataSource.addLike(userId, postid);
  }

  @override
  Future<void> deleteLike(String likeid) {
    return dataSource.deleteLike(likeid);
  }

  @override
  Future<List<LikeId>> getLikeid(String postId) {
    return dataSource.getLikeid(postId);
  }
}
