import 'package:danter/core/constants/custom_colors.dart';
import 'package:danter/core/di/di.dart';
import 'package:danter/screen/auth/bloc/auth_bloc.dart';
import 'package:danter/screen/auth/widgets/password_textField.dart';
import 'package:danter/screen/root/screens/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

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
                      SnackBar(
                        content: Text(state.exception.message),
                      ),
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
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/d.png',
                              width: 130,
                              color: themeData.colorScheme.primary,
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Text(
                              state.isLoginMode ? 'Welcome' : 'Register',
                              style: TextStyle(
                                  color: themeData.colorScheme.primary,
                                  fontSize: 22),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              state.isLoginMode
                                  ? 'Please Login to your account'
                                  : 'Set your email and password',
                              style: TextStyle(
                                  color: themeData.colorScheme.primary,
                                  fontSize: 16),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Container(
                              height: 55,
                              decoration: BoxDecoration(
                                color: themeData.colorScheme.onBackground,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: TextField(
                                  cursorHeight: 25,
                                  controller: usernameController,
                                  keyboardType: TextInputType.emailAddress,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(fontSize: 20, height: 1.3),
                                  decoration: InputDecoration(
                                    label: Text(
                                      'username',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(fontSize: 20, height: 3),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            PasswordTextField(
                                titelText: 'password',
                                onbackground: onbackground,
                                passwordController: passwordController),
                            const SizedBox(
                              height: 16,
                            ),
                            (!state.isLoginMode)
                                ? PasswordTextField(
                                    titelText: 'repeat the password',
                                    onbackground: onbackground,
                                    passwordController:
                                        passwordConfirmController)
                                : Container(),
                            const SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              height: 55,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        themeData.colorScheme.primary,
                                  ),
                                  onPressed: () {
                                    BlocProvider.of<AuthBloc>(context).add(
                                        AuthButtonIsClicked(
                                            usernameController.text,
                                            passwordController.text,
                                            passwordConfirmController.text));
                                  },
                                  child: state is AuthLoading
                                      ? SizedBox(
                                          height: 50,
                                          child: LoadingIndicator(
                                            indicatorType: Indicator.ballBeat,

                                            /// Required, The loading type of the widget
                                            colors: [
                                              themeData.scaffoldBackgroundColor,
                                            ],

                                            /// Optional, The color collections
                                            strokeWidth: 1,

                                            /// Optional, The stroke of the line, only applicable to widget which contains line
                                            backgroundColor:
                                                themeData.colorScheme.primary,

                                            /// Optional, Background of the widget
                                            pathBackgroundColor:
                                                themeData.colorScheme.primary,

                                            /// Optional, the stroke backgroundColor
                                          ),
                                        )
                                      : Text(
                                          state.isLoginMode
                                              ? 'Login'
                                              : 'Register',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: themeData
                                                  .scaffoldBackgroundColor),
                                        )),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            GestureDetector(
                              onTap: () {
                                BlocProvider.of<AuthBloc>(context)
                                    .add(AuthModeChangeIsClicked());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      state.isLoginMode
                                          ? 'Don\'t have an account?'
                                          : 'You have an account',
                                      style: TextStyle(
                                        color: themeData.colorScheme.primary,
                                      )),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    state.isLoginMode ? 'Register' : 'Login',
                                    style: TextStyle(
                                        color: themeData.colorScheme.primary,
                                        decoration: TextDecoration.underline),
                                  ),
                                ],
                              ),
                            )
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
