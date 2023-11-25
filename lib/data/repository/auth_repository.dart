import 'package:danter/data/datasource/auth_data_source.dart';
import 'package:danter/data/model/auth_info.dart';
import 'package:danter/di/di.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authRepository = AuthRepository(AuthRemoteDataSource(locator.get()));

abstract class IAuthRepository {
  Future<void> login(String username, String password);
  Future<void> signUp(String username, String password, String passwordConfirm);
}

class AuthRepository implements IAuthRepository {
  static final ValueNotifier<AuthInfo?> authChangeNotifier =
      ValueNotifier(null);

  static final SharedPreferences sharedPreferences = locator.get();

  final IAuthDataSource dataSource;

  AuthRepository(
    this.dataSource,
  );
  @override
  Future<void> login(String username, String password) async {
    final AuthInfo authInfo = await dataSource.login(username, password);
    _persistAuthTokens(authInfo);

    debugPrint("access token is: " + authInfo.token);
  }

  @override
  Future<void> signUp(
      String username, String password, String passwordConfirm) async {
    final AuthInfo authInfo =
        await dataSource.singUp(username, password, passwordConfirm);
    _persistAuthTokens(authInfo);
    debugPrint("access token is: " + authInfo.token);
  }

  Future<void> _persistAuthTokens(AuthInfo authInfo) async {
    sharedPreferences.setString("token", authInfo.token);
    sharedPreferences.setString("email", authInfo.email ?? '');
    sharedPreferences.setString("username", authInfo.username);
    sharedPreferences.setString("id", authInfo.id);
    sharedPreferences.setString("collectionId", authInfo.collectionId);
    sharedPreferences.setString("avatar", authInfo.avatar);
    sharedPreferences.setString("avatarchek", authInfo.avatarchek);
    sharedPreferences.setString("bio", authInfo.bio ?? '');
    sharedPreferences.setString("name", authInfo.name );

    loadAuthInfo();
  }

  static AuthInfo? loadAuthInfo() {
    final String token = sharedPreferences.getString("token") ?? '';
    final String email = sharedPreferences.getString("email") ?? '';
    final String username = sharedPreferences.getString("username") ?? '';
    final String id = sharedPreferences.getString("id") ?? '';
    final String collectionId =
        sharedPreferences.getString("collectionId") ?? '';
    final String avatar = sharedPreferences.getString("avatar") ?? '';
    final String avatarchek = sharedPreferences.getString("avatarchek") ?? '';
    final String bio = sharedPreferences.getString("bio") ?? '';
    final String name = sharedPreferences.getString("name") ?? '';

    if (token.isNotEmpty) {
      return AuthInfo(
          avatarchek: avatarchek,
          email: email,
          username: username,
          name: name,
          id: id,
          bio: bio,
          collectionId: collectionId,
          avatar: avatar,
          token: token);
    }
    return null;
  }

  static String readAuth() {
    return sharedPreferences.getString('token') ?? '';
  }

  static String readid() {
    return sharedPreferences.getString('id') ?? '';
  }

  static void logout() {
    sharedPreferences.clear();
    authChangeNotifier.value = null;
  }
}
