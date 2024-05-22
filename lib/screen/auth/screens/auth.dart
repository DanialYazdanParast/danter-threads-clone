import 'package:danter/core/constants/custom_colors.dart';
import 'package:danter/core/di/di.dart';
import 'package:danter/core/widgets/snackbart.dart';
import 'package:danter/screen/auth/bloc/auth_bloc.dart';
import 'package:danter/screen/auth/widgets/logo_auth.dart';
import 'package:danter/screen/auth/widgets/text_field_auth.dart';
import 'package:danter/screen/root/screens/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    const onbackground = Colors.black;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Theme(
        data: themeData.copyWith(
          //------------------------//
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              backgroundColor: onbackground,
              foregroundColor: themeData.colorScheme.secondary,
              minimumSize: const Size.fromHeight(56),
            ),
          ),

          inputDecorationTheme: InputDecorationTheme(
            labelStyle:
                const TextStyle(color: LightThemeColors.secondaryTextColor),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: LightThemeColors.secondaryTextColor,
                  width: 2,
                )),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                width: 0.5,
              ),
            ),
          ),
        ),
        child: SafeArea(
          child: BlocProvider(
            create: (context) => AuthBloc(locator.get())..add(AuthStarted()),
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              body: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const RootScreen(),
                    ));
                  } else if (state is AuthError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      snackBarApp(
                          themeData, state.exception.message, 45, context),
                    );
                  }
                },
                buildWhen: (previous, current) {
                  return current is AuthLoading ||
                      current is AuthInitial ||
                      current is AuthError;
                },
                builder: (context, state) {
                  return SingleChildScrollView(
                    child: Padding(
                        padding: EdgeInsets.only(
                            left: RootScreen.isMobile(context) ? 20 : 0,
                            right: RootScreen.isMobile(context) ? 20 : 100,
                            top: RootScreen.isMobile(context) ? 32 : 0),
                        child: !RootScreen.isMobile(context)
                            ? SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: LogoAuth(
                                          themeData: themeData, state: state),
                                    ),
                                    Expanded(
                                      child: TextFieldAuth(
                                          state: state,
                                          themeData: themeData,
                                          usernameController:
                                              usernameController,
                                          onbackground: onbackground,
                                          passwordController:
                                              passwordController,
                                          passwordConfirmController:
                                              passwordConfirmController),
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  LogoAuth(themeData: themeData, state: state),
                                  TextFieldAuth(
                                      state: state,
                                      themeData: themeData,
                                      usernameController: usernameController,
                                      onbackground: onbackground,
                                      passwordController: passwordController,
                                      passwordConfirmController:
                                          passwordConfirmController),
                                ],
                              )),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
