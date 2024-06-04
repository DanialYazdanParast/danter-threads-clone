import 'dart:io';

import 'package:danter/core/constants/theme.dart';
import 'package:danter/data/model/user.dart';
import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/core/di/di.dart';
import 'package:danter/screen/auth/screens/auth.dart';
import 'package:danter/screen/chat/bloc/chat_bloc.dart';
import 'package:danter/screen/chatList/bloc/messages_bloc.dart';
import 'package:danter/screen/chatList/bloc_chat_esktop/bloc/chat_desktop_bloc.dart';
import 'package:danter/screen/followers/bloc/followers_bloc.dart';
import 'package:danter/screen/likes/bloc/likes_bloc.dart';
import 'package:danter/screen/profile/bloc/profile_bloc.dart';
import 'package:danter/screen/root/screens/root.dart';
import 'package:danter/screen/settings/cubit/them_cubit.dart';
import 'package:danter/config/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>('Search');

  await getItInit();
  AuthRepository.loadAuthInfo();

  // await windowManager.ensureInitialized();
  if (Platform.isWindows) {
    await windowManager.setSize(const Size(1000, 700));
    await windowManager.setMinimumSize(const Size(400, 600));
  }

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => ThemCubit()),
    BlocProvider(create: (context) => ProfileBloc(locator.get())),
    BlocProvider(create: (context) => FollowersBloc(locator.get())),
    BlocProvider(create: (context) => LikesBloc(locator.get())),
    BlocProvider(create: (context) => ChatBloc(locator.get())),
    BlocProvider(create: (context) => MessagesBloc(locator.get())),
    BlocProvider(create: (context) => ChatDesktopBloc()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  @override
  Widget build(BuildContext context) {
    // IPostRepository postRepository = locator.get();
    // postRepository.getUser('5gwbvyf4alm3lxs',).then((value) {
    //   debugPrint(value.toString());
    // }).catchError((e) {
    //   debugPrint(e.toString());
    // });

    //  ThemCubit theme = BlocProvider.of<ThemCubit>(context, listen: true);

    return ThemeProvider(
        //   duration: Duration(minutes: 1),
        initTheme: ThemeSave.getTheme()
            ? MyAppThemeConfig.dark().getThemedark()
            : MyAppThemeConfig.light().getThemelight(),
        builder: (_, myTheme) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Danter',
              theme: myTheme,
              home: (AuthRepository.readAuth().isEmpty)
                  ? const AuthScreen()
                  : const RootScreen());
        });
  }
}
