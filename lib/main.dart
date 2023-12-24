import 'package:danter/data/repository/auth_repository.dart';
import 'package:danter/data/repository/post_repository.dart';
import 'package:danter/di/di.dart';
import 'package:danter/screen/auth/auth.dart';
import 'package:danter/screen/root/root.dart';
import 'package:danter/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
  await getItInit();

  AuthRepository.loadAuthInfo();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    IPostRepository postRepository = locator.get();
    postRepository.geAllfollowers('5gwbvyf4alm3lxs',).then((value) {
      debugPrint(value.toString());
    }).catchError((e) {
      debugPrint(e.toString());
    });

    const defaultTextStyle = TextStyle(
        fontFamily: 'Shabnam', color: LightThemeColors.primaryTextColor);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Danter',
        theme: ThemeData(
          hintColor: const Color.fromARGB(255, 7, 56, 192),

          //-----------------------------------

          inputDecorationTheme: const InputDecorationTheme(
              labelStyle: TextStyle(
                color: LightThemeColors.secondaryTextColor,
              ),
              iconColor: LightThemeColors.secondaryTextColor,
              border: InputBorder.none,
              floatingLabelBehavior: FloatingLabelBehavior.never),
          //-----------------------------------

          appBarTheme: const AppBarTheme(
              elevation: 0,
              backgroundColor: Colors.white,
              foregroundColor: LightThemeColors.primaryTextColor),
          //-----------------------------------
          snackBarTheme: SnackBarThemeData(
            contentTextStyle: defaultTextStyle.apply(color: Colors.white),
          ),
          //-----------------------------------
          textTheme: TextTheme(
            subtitle1: defaultTextStyle.copyWith(
                color: LightThemeColors.secondaryTextColor,
                fontSize: 17,
                fontWeight: FontWeight.w400),
            button: defaultTextStyle,
            bodyText2: defaultTextStyle,
            caption: defaultTextStyle.apply(
                color: LightThemeColors.secondaryTextColor),
            headline6: defaultTextStyle.copyWith(
                fontWeight: FontWeight.w700, fontSize: 18),
          ),
          //-----------------------------------
          colorScheme: const ColorScheme.light(
            primary: Colors.black,
            secondary: Colors.black,
            onSecondary: Colors.white,
            background: Colors.white,
          ),
          //-----------------------------------
          //   useMaterial3: true,
        ),
        home:
            (AuthRepository.readAuth().isEmpty) ? AuthScreen() : RootScreen());
  }
}
