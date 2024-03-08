import 'dart:async';
import 'package:danter/data/model/messageslist.dart';
import 'package:dio/dio.dart';
import 'package:pocketbase/pocketbase.dart';

abstract class IchatDataSource {
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
  Future<void> getchatuser(String myuserid, String useridchat);
  Future<void> addChat(
      String usersend, String userseen, String text, String roomid);
  Future<String> addRooomId(String user1, String user2);
  Future<bool> getchatuseronline(String useridchat);

  //---------------------------
  void closechatScreen();
  void closeMessagesList();
}

class ChatRemoteDataSource extends IchatDataSource {
  final Dio dio;
  ChatRemoteDataSource(this.dio);
  final pb = PocketBase('https://dan.chbk.run');

  List<MessagesList> _chat = [];
  List<MessagesList> _chatuser = [];
  bool _chatuseronline = false;
  //------------------------
  final StreamController<bool> _streamControllerListMessages =
      StreamController<bool>.broadcast();
  final StreamController<bool> _streamControllerChatuser =
      StreamController<bool>.broadcast();
  final StreamController<bool> _streamControllerUseronline =
      StreamController<bool>.broadcast();
  //------------------------

  @override
  Stream<bool> get getStreamListMessages =>
      _streamControllerListMessages.stream;
  @override
  Stream<bool> get getStreamChatUser => _streamControllerChatuser.stream;
  @override
  Stream<bool> get getStreamuseronline => _streamControllerUseronline.stream;
  //------------------------
  @override
  List<MessagesList> get listMessages => _chat;
  @override
  List<MessagesList> get chatuser => _chatuser;
  @override
  bool get chatuseronline => _chatuseronline;
  //------------------------

  @override
  realtime(String userId) async {
    pb.collection('chat').subscribe('*', (e) {
      getListMessages(userId);
    });
  }

  @override
  Future<void> getListMessages(String userId) async {
    Map<String, dynamic> qParams = {
      'filter': 'usersend="$userId" ||usersseen="$userId"',
      'expand': 'usersend,usersseen',
      'sort': '-created',
      'perPage': 500
    };

    var response =
        await dio.get('collections/chat/records', queryParameters: qParams);

    _chat = response.data['items']
        .map<MessagesList>((jsonObject) => MessagesList.fromMapson(jsonObject))
        .toList();
    if (!_streamControllerListMessages.isClosed) {
      _streamControllerListMessages.sink.add(true);
    }
  }

  @override
  Future<void> getchatuser(String myuserid, String useridchat) async {
    Map<String, dynamic> qParams = {
      'filter':
          'usersend="$myuserid"&& usersseen="$useridchat" ||usersend="$useridchat"&& usersseen="$myuserid"',
      'expand': 'usersend,usersseen',
      'sort': '-created',
      'perPage': 500
    };
    var response =
        await dio.get('collections/chat/records', queryParameters: qParams);
    _chatuser = response.data['items']
        .map<MessagesList>((jsonObject) => MessagesList.fromMapson(jsonObject))
        .toList();

    if (!_streamControllerChatuser.isClosed) {
      _streamControllerChatuser.sink.add(true);
    }
  }

  @override
  realtimeuser(String myuserid, String useridchat) {
    pb.collection('chat').subscribe(
      '*',
      (e) {
        getchatuser(myuserid, useridchat);
      },
    );
  }

  @override
  Future<void> addChat(
      String usersend, String userseen, String text, String roomid) async {
    FormData formData = FormData.fromMap({
      "usersend": usersend,
      "usersseen": userseen,
      "text": text,
      "roomid": roomid
    });
    await dio.post('collections/chat/records', data: formData);
  }

  @override
  Future<String> addRooomId(String user1, String user2) async {
    FormData formData = FormData.fromMap({
      "user1": user1,
      "user2": user2,
    });
    var response = await dio.post('collections/roomid/records', data: formData);
    return response.data['id'];
  }

  @override
  realtimeuseronline(String userId) {
    pb.collection('users').subscribe(userId, (e) {
      if (!_streamControllerUseronline.isClosed) {
        _streamControllerUseronline.sink.add(true);
        _chatuseronline = e.record!.data['online'];
      }
    });
  }

  @override
  Future<bool> getchatuseronline(String useridchat) async {
    final response = await dio.get('collections/users/records/$useridchat');
    if (!_streamControllerUseronline.isClosed) {
      _streamControllerUseronline.sink.add(true);
      _chatuseronline = response.data['online'];
    }

    return response.data['online'];
  }

  @override
  void closechatScreen() {
    _streamControllerChatuser.close();
    _streamControllerUseronline.close();
    print('vvv');
  }

  @override
  void closeMessagesList() {
    _streamControllerListMessages.close();
  }
}


//--------------------------------------
// void addChat(MessagesList chat) {
  //   _chat.add(chat);
  //   _streamController.sink.add(true);
  // }

  // void delletChat(MessagesList chat) {
  //   _chat.removeWhere((element) => element.id == chat.id);
  //   _streamController.sink.add(true);
  // }

  // void updateChat(MessagesList chat) {
  //   _chat.firstWhere((element) => element.id == chat.id).text = chat.text;
  //   _streamController.sink.add(true);
  // }

  //-------------------------------

  
  

  // @override
  // realtime(String userId) async {
  //   pb.collection('chat').subscribe('*', (e) {
  //     debugPrint(e.record!.id.toString());
      // if (e.action == 'create') {
      //   MessagesList create = MessagesList(
      //     id: e.record!.id,
      //     text: e.record!.data['text'],
      //     usersend: e.record!.data['usersend'],
      //     usersseen: e.record!.data['usersseen'],
      //     roomid: e.record!.data['roomid'],
      //   );
      //   addChat(create);
      // } else if (e.action == 'delete') {
      //   MessagesList delete = MessagesList(
      //     id: e.record!.id,
      //     text: e.record!.data['text'],
      //     usersend: e.record!.data['usersend'],
      //     usersseen: e.record!.data['usersseen'],
      //     roomid: e.record!.data['roomid'],
      //   );
      //   delletChat(delete);
      // } else if (e.action == 'update') {
      //   MessagesList update = MessagesList(
      //     id: e.record!.id,
      //     text: e.record!.data['text'],
      //     usersend: e.record!.data['usersend'],
      //     usersseen: e.record!.data['usersseen'],
      //     roomid: e.record!.data['roomid'],
      //   );
      //   updateChat(update);
      // }
  //     getchat(userId);

  //     debugPrint(e.action);
  //   });
  // }