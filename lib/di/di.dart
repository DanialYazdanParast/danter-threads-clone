


import 'package:danter/data/datasource/auth_data_source.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/screen/auth/bloc/auth_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

var locator = GetIt.instance;
Future<void> getItInit() async {
  //componets
   locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
    locator.registerSingleton<Dio>(Dio(BaseOptions(baseUrl: 'https://dan.chbk.run/api/')));
  //datasources
   locator.registerSingleton<IAuthDataSource>(AuthRemoteDataSource(locator.get()));

  //repositories
  locator.registerSingleton<IAuthRepository>(AuthRepository(locator.get()));

  //bloc

   locator.registerSingleton<AuthBloc>(AuthBloc(locator.get()));
 

}

