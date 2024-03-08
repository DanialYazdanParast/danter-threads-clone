import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class LodingCustom extends StatelessWidget {
  const LodingCustom({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Center(
      child: Container(
        height: 38,
        width: 38,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 1),
                blurRadius: 2,
              )
            ],
            color: themeData.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(100),
            border:
                Border.all(width: 1, color: themeData.colorScheme.secondary)),
        child: Center(
          child: Container(
            height: 14,
            width: 14,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: themeData.colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      ),
    ).animate(target: 1).slide(
        curve: Curves.easeIn,
        duration: 500.ms,
        begin: const Offset(0.0, -1.0),
        end: const Offset(0.0, 0.0));
  }
}
