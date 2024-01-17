import 'package:danter/data/repository/auth_repository.dart';

import 'package:danter/core/di/di.dart';
import 'package:danter/screen/auth/auth.dart';
import 'package:danter/screen/profile/bloc/profile_bloc.dart';
import 'package:danter/screen/root/root.dart';
import 'package:danter/screen/settings/cubit/them_cubit.dart';
import 'package:danter/config/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

    //  void initState() {

    //   super.initState();

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










// void main() => runApp(const MyAppa());

// class MyAppa extends StatelessWidget {
//   const MyAppa({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final isPlatformDark =
//         WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
//     final initTheme = isPlatformDark ? MyAppThemeConfig.dark().getTheme() : MyAppThemeConfig.light().getTheme();
//     return ThemeProvider(
//       initTheme: initTheme,
//       builder: (_, myTheme) {
//         return MaterialApp(
//           title: 'Flutter Demo',
//           theme: myTheme,
//           home: const MyHomePage(),
//         );
//       },
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ThemeSwitchingArea(
//       child: Scaffold(
//         drawer: Drawer(
//           child: SafeArea(
//             child: Stack(
//               children: <Widget>[
//                 Align(
//                   alignment: Alignment.topRight,
//                   child: ThemeSwitcher.withTheme(
//                     builder: (_, switcher, theme) {
//                       return IconButton(
//                         onPressed: () => switcher.changeTheme(
                          
//                           theme: theme.brightness == Brightness.light
//                               ? MyAppThemeConfig.light().getTheme() : MyAppThemeConfig.dark().getTheme(),
                              
//                         ),
//                         icon: const Icon(Icons.brightness_3, size: 25),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         appBar: AppBar(
//           title: const Text(
//             'Flutter Demo Home Page',
//           ),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: <Widget>[
//               const Text(
//                 'You have pushed the button this many times:',
//               ),
//               Text(
//                 '$_counter',
//                 style: const TextStyle(fontSize: 200),
//               ),
//               CheckboxListTile(
//                 title: const Text('Slow Animation'),
//                 value: timeDilation == 5.0,
//                 onChanged: (value) {
//                   setState(() {
//                     timeDilation = value != null && value ? 5.0 : 1.0;
//                   });
//                 },
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   ThemeSwitcher.switcher(
//                     clipper: const ThemeSwitcherBoxClipper(),
//                     builder: (context, switcher) {
//                       return TapDownButton(
//                         child: const Text('Box Animation'),
//                         onTap: (details) {
//                           switcher.changeTheme(
//                             theme: ThemeModelInheritedNotifier.of(context)
//                                         .theme
//                                         .brightness ==
//                                     Brightness.light
//                                 ? MyAppThemeConfig.light().getTheme() : MyAppThemeConfig.dark().getTheme(),
//                             offset: details.localPosition,
//                           );
//                         },
//                       );
//                     },
//                   ),
//                   ThemeSwitcher(
//                     clipper: const ThemeSwitcherCircleClipper(),
//                     builder: (context) {
//                       return TapDownButton(
//                         child: const Text('Circle Animation'),
//                         onTap: (details) {
//                           ThemeSwitcher.of(context).changeTheme(
//                             theme: ThemeModelInheritedNotifier.of(context)
//                                         .theme
//                                         .brightness ==
//                                     Brightness.dark
//                                 ? MyAppThemeConfig.light().getTheme() : MyAppThemeConfig.dark().getTheme(),
//                             offset: details.localPosition,
//                           );
//                         },
//                       );
//                     },
//                   )
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   ThemeSwitcher(
//                     clipper: const ThemeSwitcherBoxClipper(),
//                     builder: (context) {
//                       return TapDownButton(
//                         child: const Text('Box (Reverse)'),
//                         onTap: (details) {
//                           var brightness =
//                               ThemeModelInheritedNotifier.of(context)
//                                   .theme
//                                   .brightness;
//                           ThemeSwitcher.of(context).changeTheme(
//                             theme: brightness == Brightness.light
//                                 ? MyAppThemeConfig.light().getTheme() : MyAppThemeConfig.dark().getTheme(),
//                             offset: details.localPosition,
//                             isReversed:
//                                 brightness == Brightness.dark ? true : false,
//                           );
//                         },
//                       );
//                     },
//                   ),
//                   ThemeSwitcher(
//                     clipper: const ThemeSwitcherCircleClipper(),
//                     builder: (context) {
//                       return TapDownButton(
//                         child: const Text('Circle (Reverse)'),
//                         onTap: (details) {
//                           var brightness =
//                               ThemeModelInheritedNotifier.of(context)
//                                   .theme
//                                   .brightness;
//                           ThemeSwitcher.of(context).changeTheme(
//                             theme: brightness == Brightness.light
//                                 ? MyAppThemeConfig.light().getTheme() : MyAppThemeConfig.dark().getTheme(),
//                             offset: details.localPosition,
//                             isReversed:
//                                 brightness == Brightness.dark ? true : false,
//                           );
//                         },
//                       );
//                     },
//                   )
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   ThemeSwitcher(
//                     builder: (context) {
//                       return Checkbox(
//                         value: ThemeModelInheritedNotifier.of(context).theme ==
//                             MyAppThemeConfig.dark().getTheme(),
//                         onChanged: (needPink) {
//                           ThemeSwitcher.of(context).changeTheme(
//                             theme: needPink != null && needPink
//                                 ? MyAppThemeConfig.light().getTheme() : MyAppThemeConfig.dark().getTheme(),
//                           );
//                         },
//                       );
//                     },
//                   ),
//                   ThemeSwitcher(
//                     builder: (context) {
//                       return Checkbox(
//                         value: ThemeModelInheritedNotifier.of(context).theme ==
//                             MyAppThemeConfig.light().getTheme(),
//                         onChanged: (needDarkBlue) {
//                           ThemeSwitcher.of(context).changeTheme(
//                             theme: needDarkBlue != null && needDarkBlue
//                                ? MyAppThemeConfig.light().getTheme() : MyAppThemeConfig.dark().getTheme(),
//                           );
//                         },
//                       );
//                     },
//                   ),
//                   ThemeSwitcher(
//                     builder: (context) {
//                       return Checkbox(
//                         value: ThemeModelInheritedNotifier.of(context).theme ==
//                             MyAppThemeConfig.dark().getTheme(),
//                         onChanged: (needBlue) {
//                           ThemeSwitcher.of(context).changeTheme(
//                             theme: needBlue != null && needBlue
//                                 ? MyAppThemeConfig.light().getTheme() : MyAppThemeConfig.dark().getTheme(),
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: _incrementCounter,
//           tooltip: 'Increment',
//           child: const Icon(
//             Icons.add,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class TapDownButton extends StatelessWidget {
//   const TapDownButton({
//     Key? key,
//     required this.onTap,
//     required this.child,
//   }) : super(key: key);

//   final void Function(TapDownDetails details) onTap;
//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(
//           vertical: 16.0,
//           horizontal: 24.0,
//         ),
//         decoration: BoxDecoration(
//           borderRadius: const BorderRadius.all(
//             Radius.circular(24.0),
//           ),
//           border: Border.all(width: 1.0),
//         ),
//         child: child,
//       ),
//     );
//   }
// }











// import 'package:danter/data/repository/auth_repository.dart';

// import 'package:danter/di/di.dart';
// import 'package:danter/screen/auth/auth.dart';
// import 'package:danter/screen/profile/bloc/profile_bloc.dart';
// import 'package:danter/screen/root/root.dart';
// import 'package:danter/screen/settings/cubit/them_cubit.dart';
// import 'package:danter/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:animated_theme_switcher/animated_theme_switcher.dart';

// import 'package:flutter/scheduler.dart' show timeDilation;


// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await getItInit();
//   AuthRepository.loadAuthInfo();

//   runApp(MultiBlocProvider(providers: [
//     BlocProvider(
//       create: (context) => ThemCubit(),
//     ),
//     BlocProvider(create: (context) => ProfileBloc(locator.get()))
//   ], child: const MyApp()));
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     // IPostRepository postRepository = locator.get();
//     // postRepository.getUser('5gwbvyf4alm3lxs',).then((value) {
//     //   debugPrint(value.toString());
//     // }).catchError((e) {
//     //   debugPrint(e.toString());
//     // });

//     ThemCubit theme = BlocProvider.of<ThemCubit>(context, listen: true);

  
//     return BlocListener<ThemCubit, ThemState>(
//       listener: (context, state) {
//         if (theme.state is ThemChanged) {
//           setState(() {
//             SystemChrome.setSystemUIOverlayStyle(
//               SystemUiOverlayStyle(
//                 statusBarColor: theme.isDark ? Colors.black : Colors.white,
//                 statusBarIconBrightness:
//                     theme.isDark ? Brightness.light : Brightness.dark,
//                 systemNavigationBarColor:
//                     theme.isDark ? Colors.black : Colors.white,
//                 systemNavigationBarIconBrightness:
//                     theme.isDark ? Brightness.light : Brightness.dark,
//               ),
//             );
//           });
//         } else {
//           SystemUiOverlayStyle(
//             statusBarColor: theme.isDark ? Colors.black : Colors.white,
//             statusBarIconBrightness:
//                 theme.isDark ? Brightness.light : Brightness.dark,
//             systemNavigationBarColor:
//                 theme.isDark ? Colors.black : Colors.white,
//             systemNavigationBarIconBrightness:
//                 theme.isDark ? Brightness.light : Brightness.dark,
//           );
//         }
//       },
//       child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'Danter',
//           theme: theme.isDark
//               ? MyAppThemeConfig.dark().getTheme()
//               : MyAppThemeConfig.light().getTheme(),
//           home: (AuthRepository.readAuth().isEmpty)
//               ? AuthScreen()
//               : RootScreen()),
//     );
//   }
// }
