import 'package:danter/data/datasource/post_data_source.dart';
import 'package:danter/data/model/follow.dart';
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
  Future<List<LikeId>> getLikeid(String postId, String userId);
  Future<int> getTotalfollowers(String userId);
  Future<int> getTruefollowing(String myuserId, String userIdProfile);
  Future<void> addfollow(String myuserId, String userIdProfile);
  Future<List<FollowId>> getFollowid(String myuserId, String userIdProfile);
  Future<void> deleteFollow(String followid);

  Future<List<LikeUser>> getAllLikePost(String postId);
  Future<List<Followers>> geAllfollowers(String userId);
  Future<List<Following>> geAllfollowing(String userId);
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
  Future<List<LikeId>> getLikeid(String postId, String userId) {
    return dataSource.getLikeid(postId, userId);
  }

  @override
  Future<int> getTotalfollowers(String userId) {
    return dataSource.getTotalfollowers(userId);
  }

  @override
  Future<int> getTruefollowing(String myuserId, String userIdProfile) {
    return dataSource.getTruefollowing(myuserId, userIdProfile);
  }

  @override
  Future<void> addfollow(String myuserId, String userIdProfile) {
    return dataSource.addfollow(myuserId, userIdProfile);
  }

  @override
  Future<List<FollowId>> getFollowid(String myuserId, String userIdProfile) {
    return dataSource.getFollowid(myuserId, userIdProfile);
  }

  @override
  Future<void> deleteFollow(String followid) {
    return dataSource.deleteFollow(followid);
  }

  @override
  Future<List<LikeUser>> getAllLikePost(String postId) {
    return dataSource.getAllLikePost(postId);
  }

  @override
  Future<List<Followers>> geAllfollowers(String userId) {
    return dataSource.geAllfollowers(userId);
  }

  @override
  Future<List<Following>> geAllfollowing(String userId) {
    return dataSource.geAllfollowing(userId);
  }
}
