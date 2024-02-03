import 'package:danter/data/model/user.dart';
import 'package:danter/data/repository/auth_repository.dart';

import 'package:danter/core/di/di.dart';
import 'package:danter/screen/auth/auth.dart';
import 'package:danter/screen/profile/bloc/profile_bloc.dart';
import 'package:danter/screen/root/root.dart';
import 'package:danter/screen/settings/cubit/them_cubit.dart';
import 'package:danter/config/theme/theme.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>('Search');

  await getItInit();
  AuthRepository.loadAuthInfo();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (context) => ThemCubit(),
    ),
    BlocProvider(create: (context) => ProfileBloc(locator.get()))
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // IPostRepository postRepository = locator.get();
    // postRepository.getUser('5gwbvyf4alm3lxs',).then((value) {
    //   debugPrint(value.toString());
    // }).catchError((e) {
    //   debugPrint(e.toString());
    // });

    ThemCubit theme = BlocProvider.of<ThemCubit>(context, listen: true);

    return ThemeProvider(
        //   duration: Duration(minutes: 1),

        initTheme: theme.isDark
            ? MyAppThemeConfig.dark().getThemedark()
            : MyAppThemeConfig.light().getThemelight(),
        builder: (_, myTheme) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Danter',
              theme: myTheme,
              home: (AuthRepository.readAuth().isEmpty)
                  ? const AuthScreen()
                  : RootScreen());
        });
  }
}
