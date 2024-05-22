import 'package:danter/core/constants/custom_colors.dart';
import 'package:danter/screen/root/screens/root.dart';
import 'package:flutter/material.dart';

SnackBar snackBarApp(
    ThemeData themeData, String text, double bottom, BuildContext context) {
  return SnackBar(
    backgroundColor: DarkThemeColors.onbackground.withOpacity(0.9),
    margin: EdgeInsets.only(
        bottom: bottom,
        left: !RootScreen.isMobile(context)
            ? MediaQuery.of(context).size.width * 0.2
            : 15,
        right: !RootScreen.isMobile(context)
            ? MediaQuery.of(context).size.width * 0.2
            : 0),
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
