import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.onbackground,
    required this.passwordController,
    required this.titelText,
  });

  final TextEditingController passwordController;
  final String titelText;
  final Color onbackground;

  @override
  State<PasswordTextField> createState() => PasswordTextFieldState();
}

class PasswordTextFieldState extends State<PasswordTextField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        cursorHeight: 25,
        controller: widget.passwordController,
        keyboardType: TextInputType.visiblePassword,
        obscureText: obscureText,
        style: Theme.of(context)
            .textTheme
            .labelSmall!
            .copyWith(fontSize: 20, height: 1.3),
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
                color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
              )),
          label: Text(
            widget.titelText,
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(fontSize: 20, height: 3),
          ),
        ),
      ),
    );
  }
}
