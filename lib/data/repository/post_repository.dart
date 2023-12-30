import 'package:danter/data/datasource/post_data_source.dart';
import 'package:danter/data/model/follow.dart';
import 'package:danter/data/model/like.dart';
import 'package:danter/data/model/post.dart';
import 'package:danter/data/model/replyphoto.dart';
import 'package:danter/data/model/user.dart';
import 'package:danter/data/repository/auth_repository.dart';

abstract class IPostRepository {
  Future<List<PostEntity>> getPost(String userId);
  Future<List<PostEntity>> getPostProfile(String userId);
  Future<int> getPosttotalLike(String postId);
  Future<int> getPosttotalreplise(String postId);
  Future<List<Replyphoto>> getPosttotalreplisePhoto(String postId);
  Future<void> sendPost(String userId, String text, image);
  Future<int> getLikeuser(String postId, String userId);
  Future<void> addLike(String userId, String postid);
  Future<void> deleteLike(String userId, String postid);
  Future<List<LikeId>> getLikeid(String postId, String userId);
  Future<int> getTotalfollowers(String userId);
  Future<int> getTruefollowing(String myuserId, String userIdProfile);
  Future<void> addfollow(String myuserId, String userIdProfile);
  Future<List<FollowId>> getFollowid(String myuserId, String userIdProfile);
  Future<void> deleteFollow(String myuserId, String userIdProfile);
  Future<List<LikeUser>> getAllLikePost(String postId);
  Future<List<Followers>> geAllfollowers(String userId);
  Future<List<Following>> geAllfollowing(String userId);
  Future<void> deletePost(String postid);
  Future<void> sendNameAndBio(String userid, String name, String bio);
  Future<void> sendImagePorofile(String userid, image);
  Future<List<PostReply>> getAllReply(String userId);
  Future<List<PostEntityAll>> getAllpostHome(String userId);
  Future<List<PostEntityAll>> getAllReplyPost(String userId, String postId);
 Future<List<PostEntityAll>> getAllPostReply(String userId ,String postId);
 Future<List<PostEntityAll>> getAllPostProfile(String userId );

 Future<List<PostEntity>> getPostReply(String postId);
 Future<List<PostEntity>> getReplyPost(String postId);
 Future<void> removeFollow(String myuserId, String userIdProfile);
 Future<User> getUser(String userId);
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
  Future<void> sendPost(String userId, String text, image) {
    return dataSource.sendPost(userId, text, image);
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
  Future<void> deleteLike(String userId, String postid) {
    return dataSource.deleteLike(userId,postid);
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
  Future<void> deleteFollow(String myuserId, String userIdProfile) {
    return dataSource.deleteFollow(myuserId,userIdProfile);
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
  Future<List<PostEntityAll>> getAllpostHome(String userId) {
    return dataSource.getAllpostHome(userId);
  }

  @override
  Future<List<PostEntityAll>> getAllReplyPost(String userId, String postId) {
    return dataSource.getAllReplyPost(userId, postId);
  }
  
  @override
  Future<List<PostEntityAll>> getAllPostReply(String userId, String postId) {
     return dataSource.getAllPostReply(userId, postId);
  }
  
  @override
  Future<List<PostEntityAll>> getAllPostProfile(String userId) {
     return dataSource.getAllPostProfile(userId,);
  }
  
  @override
  Future<List<PostEntity>> getPostReply(String postId) {
    return dataSource.getPostReply(postId,);
  }
  
  @override
  Future<List<PostEntity>> getReplyPost(String postId) {
    return dataSource.getReplyPost(postId,);
  }
  
  @override
  Future<void> removeFollow(String myuserId, String userIdProfile) {
    return dataSource.removeFollow(myuserId,userIdProfile);
  }
  
  @override
  Future<User> getUser(String userId) {
     return dataSource.getUser(userId);
  }
}
