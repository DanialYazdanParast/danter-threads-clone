


import 'package:danter/data/datasource/auth_data_source.dart';
import 'package:danter/data/datasource/post_data_source.dart';
import 'package:danter/data/datasource/reply_data_source.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/data/repository/post_repository.dart';
import 'package:danter/data/repository/reply_repository.dart';
import 'package:danter/screen/auth/bloc/auth_bloc.dart';
import 'package:danter/screen/home/bloc/home_bloc.dart';
import 'package:danter/screen/profile/bloc/profile_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

var locator = GetIt.instance;
Future<void> getItInit() async {
  //componets
   locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
    locator.registerSingleton<Dio>(Dio(BaseOptions(baseUrl: 'https://dan.chbk.run/api/')));
  //---------datasources-------------//
   locator.registerSingleton<IAuthDataSource>(AuthRemoteDataSource(locator.get()));
   locator.registerSingleton<IPostDataSource>(PostRemoteDataSource(locator.get()));
   locator.registerSingleton<IReplyDataSource>(ReplyRemoteDataSource(locator.get()));

  //-----------repositories-----------//
  locator.registerSingleton<IAuthRepository>(AuthRepository(locator.get()));
  locator.registerSingleton<IPostRepository>(PostRepository(locator.get()));
  locator.registerSingleton<IReplyRepository>(ReplyRepository(locator.get()));

  //bloc

 //  locator.registerFactory<AuthBloc>(()=> AuthBloc(locator.get()));
 //  locator.registerFactory<HomeBloc>(()=> HomeBloc(locator.get()));
// locator.registerSingleton<ProfileBloc>(ProfileBloc(locator.get()));
 

}

