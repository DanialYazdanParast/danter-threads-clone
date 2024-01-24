import 'package:danter/data/datasource/post_data_source.dart';
import 'package:danter/data/model/follow.dart';
import 'package:danter/data/model/like.dart';
import 'package:danter/data/model/post.dart';

import 'package:danter/data/model/user.dart';
import 'package:danter/data/repository/auth_repository.dart';

abstract class IPostRepository {
  Future<List<PostEntity>> getPost(String userId);
  Future<List<PostEntity>> getPostProfile(String userId);
  Future<void> sendPost(String userId, String text, image);
  Future<void> addLike(String userId, String postid);
  Future<void> deleteLike(String userId, String postid);
  Future<void> addfollow(String myuserId, String userIdProfile);
  Future<void> deleteFollow(String myuserId, String userIdProfile);
  Future<List<LikeUser>> getAllLikePost(String postId);
  Future<List<Followers>> geAllfollowers(String userId);
  Future<List<Following>> geAllfollowing(String userId);
  Future<void> deletePost(String postid);
  Future<void> sendNameAndBio(String userid, String name, String bio);
  Future<void> sendImagePorofile(String userid, image);
  Future<List<PostReply>> getAllReply(String userId);
  Future<List<PostEntity>> getPostReply(String postId);
  Future<List<PostEntity>> getReplyPost(String postId);
  Future<void> removeFollow(String myuserId, String userIdProfile);
  Future<User> getUser(String userId);
  Future<List<User>> getAllUser(String userId);
  Future<List<User>> getSearchUser(String keyuserName, String userId);
}

class PostRepository implements IPostRepository {
  final IPostDataSource dataSource;
  PostRepository(this.dataSource);
  @override
  Future<List<PostEntity>> getPost(String userId) {
    return dataSource.getPost(userId);
  }

  @override
  Future<List<PostEntity>> getPostProfile(String userId) {
    return dataSource.getPostProfile(userId);
  }

  @override
  Future<void> sendPost(String userId, String text, image) {
    return dataSource.sendPost(userId, text, image);
  }

  @override
  Future<void> addLike(String userId, String postid) {
    return dataSource.addLike(userId, postid);
  }

  @override
  Future<void> deleteLike(String userId, String postid) {
    return dataSource.deleteLike(userId, postid);
  }

  @override
  Future<void> addfollow(String myuserId, String userIdProfile) {
    return dataSource.addfollow(myuserId, userIdProfile);
  }

  @override
  Future<void> deleteFollow(String myuserId, String userIdProfile) {
    return dataSource.deleteFollow(myuserId, userIdProfile);
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

  @override
  Future<void> deletePost(String postid) {
    return dataSource.deletePost(postid);
  }

  @override
  Future<void> sendNameAndBio(String userid, String name, String bio) async {
    final User user = await dataSource.sendNameAndBio(userid, name, bio);
    AuthRepository.persistAuthTokens(user);
  }

  @override
  Future<void> sendImagePorofile(String userid, image) async {
    final User user = await dataSource.sendImagePorofile(userid, image);
    AuthRepository.persistAuthTokens(user);
  }

  @override
  Future<List<PostReply>> getAllReply(String userId) {
    return dataSource.getAllReply(userId);
  }

  @override
  Future<List<PostEntity>> getPostReply(String postId) {
    return dataSource.getPostReply(
      postId,
    );
  }

  @override
  Future<List<PostEntity>> getReplyPost(String postId) {
    return dataSource.getReplyPost(
      postId,
    );
  }

  @override
  Future<void> removeFollow(String myuserId, String userIdProfile) {
    return dataSource.removeFollow(myuserId, userIdProfile);
  }

  @override
  Future<User> getUser(String userId) {
    return dataSource.getUser(userId);
  }

  @override
  Future<List<User>> getAllUser(String userId) {
    return dataSource.getAllUser(userId);
  }

  @override
  Future<List<User>> getSearchUser(String keyuserName, String userId) {
    return dataSource.getSearchUser(keyuserName, userId);
  }
}
