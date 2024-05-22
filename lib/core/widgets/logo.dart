import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double size;

  const Logo({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return SizedBox(
      height: size,
      width: size,
      child: Image.asset(
        'assets/images/d.png',
        color: themeData.colorScheme.onPrimary,
      ),
    );
  }
}
