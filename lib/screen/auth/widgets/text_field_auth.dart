import 'package:danter/screen/auth/bloc/auth_bloc.dart';
import 'package:danter/screen/auth/widgets/password_textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

class TextFieldAuth extends StatelessWidget {
  const TextFieldAuth({
    super.key,
    required this.themeData,
    required this.usernameController,
    required this.onbackground,
    required this.passwordController,
    required this.passwordConfirmController,
    required this.state,
  });

  final ThemeData themeData;
  final TextEditingController usernameController;
  final Color onbackground;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmController;
  final AuthState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
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
                passwordController: passwordConfirmController)
            : Container(),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 55,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: themeData.colorScheme.primary,
              ),
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(AuthButtonIsClicked(
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
                        backgroundColor: themeData.colorScheme.primary,

                        /// Optional, Background of the widget
                        pathBackgroundColor: themeData.colorScheme.primary,

                        /// Optional, the stroke backgroundColor
                      ),
                    )
                  : Text(
                      state.isLoginMode ? 'Login' : 'Register',
                      style: TextStyle(
                          fontSize: 18,
                          color: themeData.scaffoldBackgroundColor),
                    )),
        ),
        const SizedBox(
          height: 24,
        ),
        GestureDetector(
          onTap: () {
            BlocProvider.of<AuthBloc>(context).add(AuthModeChangeIsClicked());
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  state.isLoginMode
                      ? 'Don\'t have an account?'
                      : 'You have an account?',
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
    );
  }
}
