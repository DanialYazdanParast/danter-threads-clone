import 'package:danter/data/datasource/messages_datasource.dart';
import 'package:danter/data/model/messageslist.dart';

abstract class IchatRepository {
  realtime(String userId);
  realtimeuser(String myuserid, String useridchat);
  realtimeuseronline(String userId);
  //---------------------------
  Stream<bool> get getStreamListMessages;
  Stream<bool> get getStreamChatUser;
  Stream<bool> get getStreamuseronline;
  //---------------------------
  List<MessagesList> get listMessages;
  List<MessagesList> get chatuser;
  bool get chatuseronline;
  //---------------------------
  Future<void> getListMessages(String userId);
  Future<List<MessagesList>> getchatuser(String myuserid, String useridchat);
  Future<void> addChat(
      String usersend, String userseen, String text, String roomid);
  Future<String> addRooomId(String user1, String user2);
  Future<bool> getchatuseronline(String useridchat);
  //---------------------------
  void closechatScreen();
  void closeMessagesList();
}

class ChatRepository implements IchatRepository {
  final IchatDataSource dataSource;

  ChatRepository(this.dataSource);

  @override
  Future<void> addChat(
      String usersend, String userseen, String text, String roomid) {
    return dataSource.addChat(usersend, userseen, text, roomid);
  }

  @override
  Future<String> addRooomId(String user1, String user2) {
    return dataSource.addRooomId(user1, user2);
  }

  @override
  List<MessagesList> get chatuser => dataSource.chatuser;

  @override
  bool get chatuseronline => dataSource.chatuseronline;

  @override
  void closeMessagesList() {
    return dataSource.closeMessagesList();
  }

  @override
  void closechatScreen() {
    return dataSource.closechatScreen();
  }

  @override
  Future<void> getListMessages(String userId) {
    return dataSource.getListMessages(userId);
  }

  @override
  Stream<bool> get getStreamChatUser => dataSource.getStreamChatUser;

  @override
  Stream<bool> get getStreamListMessages => dataSource.getStreamListMessages;

  @override
  Stream<bool> get getStreamuseronline => dataSource.getStreamuseronline;

  @override
  Future<List<MessagesList>> getchatuser(String myuserid, String useridchat) {
    return dataSource.getchatuser(myuserid, useridchat);
  }

  @override
  Future<bool> getchatuseronline(String useridchat) {
    return dataSource.getchatuseronline(useridchat);
  }

  @override
  List<MessagesList> get listMessages => dataSource.listMessages;

  @override
  realtime(String userId) {
    return dataSource.realtime(userId);
  }

  @override
  realtimeuser(String myuserid, String useridchat) {
    return dataSource.realtimeuser(myuserid, useridchat);
  }

  @override
  realtimeuseronline(String userId) {
    return dataSource.realtimeuseronline(userId);
  }
}
