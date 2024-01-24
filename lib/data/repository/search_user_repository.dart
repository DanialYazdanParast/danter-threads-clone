import 'package:danter/data/datasource/search_user_source.dart';
import 'package:danter/data/model/user.dart';

abstract class ISearchUserRepository {
  Future<void> addSearchUser(User user);
  Future<List<User>> getAllSearchUser();
  Future<void> deleteSearchUser(User user);
  Future<void> deleteAllSearchUser();
}

class SearchUserRepository extends ISearchUserRepository {
  final ISearchUserDatasource datasource;
  SearchUserRepository(this.datasource);
  @override
  Future<void> addSearchUser(User user) {
    return datasource.addSearchUser(user);
  }

  @override
  Future<void> deleteAllSearchUser() {
    return datasource.deleteAllSearchUser();
  }

  @override
  Future<void> deleteSearchUser(User user) {
    return datasource.deleteSearchUser(user);
  }

  @override
  Future<List<User>> getAllSearchUser() {
    return datasource.getAllSearchUser();
  }
}
