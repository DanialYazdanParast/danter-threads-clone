import 'package:danter/data/model/auth_info.dart';
import 'package:danter/core/util/response_validator.dart';
import 'package:dio/dio.dart';

abstract class IAuthDataSource {
  Future<AuthInfo> login(String username, String password);
  Future<AuthInfo> singUp(
      String username, String password, String passwordConfirm);
}

class AuthRemoteDataSource with HttpResponseValidat implements IAuthDataSource {
  final Dio _dio;
  AuthRemoteDataSource(this._dio);
  @override
  Future<AuthInfo> login(String username, String password) async {
    final response = await _dio.post('collections/users/auth-with-password',
        data: {"identity": username, "password": password});
    validatResponse(response);
    return AuthInfo.fromJson(response.data);
  }

  @override
  Future<AuthInfo> singUp(
      String username, String password, String passwordConfirm) async {
    final response = await _dio.post('collections/users/records', data: {
      "username": username,
      "password": password,
      "passwordConfirm": passwordConfirm
    });
    validatResponse(response);
    return login(username, password);
  }
}
