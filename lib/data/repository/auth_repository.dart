import 'package:danter/data/datasource/auth_data_source.dart';
import 'package:danter/data/model/auth_info.dart';
import 'package:danter/core/di/di.dart';

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
  static final SharedPreferences sharedPreferencestoken = locator.get();

  final IAuthDataSource dataSource;

  AuthRepository(
    this.dataSource,
  );
  @override
  Future<void> login(String username, String password) async {
    final AuthInfo authInfo = await dataSource.login(username, password);
    persistAuthTokens(authInfo);

    debugPrint("access token is: " + authInfo.token);
    sharedPreferencestoken.setString("token", authInfo.token);
  }

  @override
  Future<void> signUp(
      String username, String password, String passwordConfirm) async {
    final AuthInfo authInfo =
        await dataSource.singUp(username, password, passwordConfirm);
    persistAuthTokens(authInfo);
    debugPrint("access token is: " + authInfo.token);
    sharedPreferencestoken.setString("token", authInfo.token);
  }

static  Future<void> persistAuthTokens( authInfo) async {
    sharedPreferences.setString("username", authInfo.username);
    sharedPreferences.setString("id", authInfo.id);
    sharedPreferences.setString("collectionId", authInfo.collectionId);
    sharedPreferences.setString("avatar", authInfo.avatar);
    sharedPreferences.setString("avatarchek", authInfo.avatarchek);
    sharedPreferences.setString("bio", authInfo.bio  ?? '' );
    sharedPreferences.setString("name", authInfo.name  ?? '');

    loadAuthInfo();
  }

  static  loadAuthInfo() {
    final String username = sharedPreferences.getString("username") ?? '';
    final String id = sharedPreferences.getString("id") ?? '';
    final String collectionId = sharedPreferences.getString("collectionId") ?? '';
    final String avatar = sharedPreferences.getString("avatar") ?? '';
    final String avatarchek = sharedPreferences.getString("avatarchek") ?? '';
    final String bio = sharedPreferences.getString("bio") ?? '';
    final String name = sharedPreferences.getString("name") ?? '';

    return AuthInfo(
        avatarchek: avatarchek,
        username: username,
        name: name,
        id: id,
        bio: bio,
        collectionId: collectionId,
        avatar: avatar,
       );
  }

  static String readAuth() {
    return sharedPreferencestoken.getString('token') ?? '';
  }

  static String readid() {
    return sharedPreferences.getString('id') ?? '';
  }

  static void logout() {
    sharedPreferences.clear();
    authChangeNotifier.value = null;
  }
}
