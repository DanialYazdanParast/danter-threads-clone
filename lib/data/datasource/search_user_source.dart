import 'package:danter/data/model/user.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class ISearchUserDatasource {
  Future<void> addSearchUser(User user);
  Future<List<User>> getAllSearchUser();
  Future<void> deleteSearchUser(User user);
  Future<void> deleteAllSearchUser();
}

class SearchUserLocalDatasource extends ISearchUserDatasource {
  var box = Hive.box<User>('Search');
  @override
  Future<void> addSearchUser(User user) async {
    box.add(user);
  }

  @override
  Future<List<User>> getAllSearchUser() async {
    return box.values.toList();
  }

  @override
  Future<void> deleteSearchUser(User user) async {
    box.delete(user.key);
  }

  @override
  Future<void> deleteAllSearchUser() async {
    box.deleteAll(box.keys);
  }
}
