import 'package:danter/core/constants/custom_colors.dart';
import 'package:danter/core/di/di.dart';
import 'package:danter/screen/auth/bloc/auth_bloc.dart';
import 'package:danter/screen/root/root.dart';
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
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    const onbackground = Colors.black;
    return Directionality(
      textDirection: TextDirection.rtl,
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
          //------------------------//
          // snackBarTheme: const SnackBarThemeData(
          //     backgroundColor: Colors.black, contentTextStyle: TextStyle()),
          // colorScheme: themeData.colorScheme.copyWith(
          //   onSurface: Colors.white,
          //   primary: LightThemeColors.secondaryTextColor,
          //   secondary: Colors.black,
          //   onBackground: onbackground,
          // ),

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
              //  backgroundColor: Colors.red,
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
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Text(
                              state.isLoginMode ? 'خوش آمدید' : 'ثبت نام',
                              style: const TextStyle(
                                  color: onbackground, fontSize: 22),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              state.isLoginMode
                                  ? 'لطفا وارد حساب کاربری خود شوید'
                                  : 'ایمیل و رمز عبور خود را تعیین کنید',
                              style: const TextStyle(
                                  color: onbackground, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Container(
                              height: 55,
                              decoration: BoxDecoration(
                                color: LightThemeColors.secondaryTextColor
                                    .withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: TextField(
                                  controller: usernameController,
                                  keyboardType: TextInputType.emailAddress,
                                  style: const TextStyle(
                                      fontSize: 18.0, color: Colors.black),
                                  decoration: const InputDecoration(
                                    label: Text(
                                      'نام کاربری',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            _PasswordTextField(
                                titelText: 'رمز عبور',
                                onbackground: onbackground,
                                passwordController: passwordController),
                            const SizedBox(
                              height: 16,
                            ),
                            (!state.isLoginMode)
                                ? _PasswordTextField(
                                    titelText: ' تکرار رمز عبور',
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
                                  onPressed: () {
                                    BlocProvider.of<AuthBloc>(context).add(
                                        AuthButtonIsClicked(
                                            usernameController.text,
                                            passwordController.text,
                                            passwordConfirmController.text));
                                  },
                                  child: state is AuthLoading
                                      ? const SizedBox(
                                          height: 50,
                                          child: LoadingIndicator(
                                              indicatorType: Indicator.ballBeat,

                                              /// Required, The loading type of the widget
                                              colors: [Colors.white],

                                              /// Optional, The color collections
                                              strokeWidth: 1,

                                              /// Optional, The stroke of the line, only applicable to widget which contains line
                                              backgroundColor: Colors.black,

                                              /// Optional, Background of the widget
                                              pathBackgroundColor: Colors.black

                                              /// Optional, the stroke backgroundColor
                                              ),
                                        )
                                      : Text(
                                          state.isLoginMode
                                              ? 'ورود'
                                              : 'ثبت نام',
                                          style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
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
                                          ? 'حساب کاربری ندارید؟'
                                          : 'حساب کار بری دارید',
                                      style: const TextStyle(
                                        color:
                                            LightThemeColors.secondaryTextColor,
                                      )),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    state.isLoginMode ? 'ثبت نام ' : 'ورود',
                                    style: const TextStyle(
                                        color:
                                            LightThemeColors.secondaryTextColor,
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

class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField({
    super.key,
    required this.onbackground,
    required this.passwordController,
    required this.titelText,
  });

  final TextEditingController passwordController;
  final String titelText;
  final Color onbackground;

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: LightThemeColors.secondaryTextColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: widget.passwordController,
        keyboardType: TextInputType.visiblePassword,
        obscureText: obscureText,
        style: const TextStyle(fontSize: 18.0, color: Colors.black),
        decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              icon: Icon(
                obscureText
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: widget.onbackground.withOpacity(0.6),
              )),
          label: Text(widget.titelText),
        ),
      ),
    );
  }
}
