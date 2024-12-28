import 'package:danter/core/constants/variable_onstants.dart';
import 'package:danter/data/datasource/auth_data_source.dart';
import 'package:danter/data/datasource/messages_datasource.dart';
import 'package:danter/data/datasource/post_data_source.dart';
import 'package:danter/data/datasource/reply_data_source.dart';
import 'package:danter/data/datasource/search_user_source.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/data/repository/messages_repository.dart';
import 'package:danter/data/repository/post_repository.dart';
import 'package:danter/data/repository/reply_repository.dart';
import 'package:danter/data/repository/search_user_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:shared_preferences/shared_preferences.dart';

var locator = GetIt.instance;
Future<void> getItInit() async {
  ///componets
  locator.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
  locator.registerSingleton<Dio>(
      Dio(BaseOptions(baseUrl: '${VariableConstants.domain}/api/')));
  locator.registerSingleton<PocketBase>(PocketBase(VariableConstants.domain));

  ///datasources
  locator
      .registerSingleton<IAuthDataSource>(AuthRemoteDataSource(locator.get()));
  locator.registerSingleton<IPostDataSource>(
      PostRemoteDataSource(locator.get(), locator.get()));
  locator.registerSingleton<IReplyDataSource>(
      ReplyRemoteDataSource(locator.get()));
  locator.registerSingleton<ISearchUserDatasource>(SearchUserLocalDatasource());
  locator.registerFactory<IchatDataSource>(
    () => ChatRemoteDataSource(locator.get(), locator.get()),
  );

  ///repositories
  locator.registerSingleton<IAuthRepository>(AuthRepository(locator.get()));
  locator.registerSingleton<IPostRepository>(PostRepository(locator.get()));
  locator.registerSingleton<IReplyRepository>(ReplyRepository(locator.get()));
  locator.registerSingleton<ISearchUserRepository>(
      SearchUserRepository(locator.get()));
  locator.registerFactory<IchatRepository>(() => ChatRepository(locator.get()));
}
