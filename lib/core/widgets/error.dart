import 'package:danter/core/util/exceptions.dart';
import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget {
  final AppException exception;
  final GestureTapCallback onpressed;
  const AppErrorWidget({
    super.key,
    required this.exception,
    required this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return InkWell(
      onTap: onpressed,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              exception.message,
              style: themeData.textTheme.titleSmall,
            ),
            Text(
              'Try Again',
              style: themeData.textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
