import 'package:danter/theme.dart';
import 'package:flutter/material.dart';

SnackBar snackBarApp(ThemeData themeData, String text, double bottom) {
  return SnackBar(
    backgroundColor: DarkThemeColors.onbackground.withOpacity(0.9),
    margin: EdgeInsets.only(bottom: bottom, left: 15, right: 15),
    padding: const EdgeInsets.symmetric(
      horizontal: 10,
    ),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    content: Center(
        child: Padding(
      padding: const EdgeInsets.all(14),
      child: Text(text,
          style: themeData.textTheme.titleMedium!
              .copyWith(color: DarkThemeColors.primaryTextColor)),
    )),
  );
}
