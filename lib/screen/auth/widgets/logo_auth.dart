import 'package:danter/screen/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';

class LogoAuth extends StatelessWidget {
  const LogoAuth({
    super.key,
    required this.themeData,
    required this.state,
  });

  final ThemeData themeData;
  final AuthState state;

  @override
  Widget build(BuildContext context) {
    return Column(
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
          style: TextStyle(color: themeData.colorScheme.primary, fontSize: 22),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          state.isLoginMode
              ? 'Please Login to your account'
              : 'Set your email and password',
          style: TextStyle(color: themeData.colorScheme.primary, fontSize: 16),
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }
}
