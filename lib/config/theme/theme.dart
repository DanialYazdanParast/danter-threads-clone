import 'package:danter/core/constants/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppThemeConfig {
  final Color primaryColor;
  final Color secondaryColor;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color onbackground;

  MyAppThemeConfig.dark()
      : primaryColor = DarkThemeColors.primaryColor,
        secondaryColor = DarkThemeColors.secondaryColor,
        primaryTextColor = DarkThemeColors.primaryTextColor,
        secondaryTextColor = DarkThemeColors.secondaryTextColor,
        onbackground = DarkThemeColors.onbackground;

  MyAppThemeConfig.light()
      : primaryColor = LightThemeColors.primaryColor,
        secondaryColor = LightThemeColors.secondaryColor,
        primaryTextColor = LightThemeColors.primaryTextColor,
        secondaryTextColor = LightThemeColors.secondaryTextColor,
        onbackground = LightThemeColors.onbackground;
  ThemeData getThemelight() {
    final defaultTextStyle = GoogleFonts.vazirmatn();
    // TextStyle(fontFamily: 'Shabnam', color: primaryTextColor);
    return ThemeData(
      //-----------------------------------

      scaffoldBackgroundColor: primaryColor,

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
            side: MaterialStateProperty.all(BorderSide(
          color: secondaryTextColor.withOpacity(0.8),
          width: 1,
        ))),
      ),

      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: secondaryTextColor,
        ),
        iconColor: secondaryTextColor,
        border: InputBorder.none,
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      //-----------------------------------

      appBarTheme: AppBarTheme(
        titleTextStyle: defaultTextStyle.copyWith(
            fontSize: 18, color: primaryTextColor, fontWeight: FontWeight.w400),
        elevation: 0,
        backgroundColor: primaryColor,
        foregroundColor: primaryTextColor,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: primaryColor,

            // Status bar brightness (optional)
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.dark,
            systemNavigationBarColor: primaryColor,
            systemNavigationBarIconBrightness:
                Brightness.dark // For iOS (dark icons)
            ),
      ),
      //-----------------------------------
      snackBarTheme: SnackBarThemeData(
        contentTextStyle: defaultTextStyle.apply(color: Colors.white),
      ),
      //-----------------------------------

      textTheme: TextTheme(
        titleLarge: defaultTextStyle.copyWith(
            fontSize: 16, color: primaryTextColor, fontWeight: FontWeight.w600),
        titleMedium: defaultTextStyle.copyWith(
            fontSize: 16, color: primaryTextColor, fontWeight: FontWeight.w300),
        titleSmall: defaultTextStyle.copyWith(
            fontSize: 16,
            color: secondaryTextColor,
            fontWeight: FontWeight.w400),
        labelSmall: defaultTextStyle.copyWith(
            fontSize: 14,
            color: secondaryTextColor,
            fontWeight: FontWeight.w400),
        headlineLarge: defaultTextStyle.copyWith(
            fontSize: 30, color: primaryTextColor, fontWeight: FontWeight.bold),
        labelLarge: defaultTextStyle.copyWith(
            fontSize: 24, color: primaryTextColor, fontWeight: FontWeight.w500),
      ),

      //-----------------------------------
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,

      colorScheme: ColorScheme.light(
          primary: primaryTextColor,
          onPrimary: primaryTextColor,
          secondary: secondaryColor,
          onSecondary: secondaryTextColor,
          background: Colors.white,
          surface: secondaryTextColor.withOpacity(0.5),
          onSurface: primaryTextColor,
          onBackground: onbackground),
      //-----------------------------------
      useMaterial3: true,
    );
  }

  ThemeData getThemedark() {
    final defaultTextStyle = GoogleFonts.vazirmatn();
    return ThemeData(
      //-----------------------------------

      scaffoldBackgroundColor: primaryColor,

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
            side: MaterialStateProperty.all(BorderSide(
          color: secondaryTextColor.withOpacity(0.8),
          width: 1,
        ))),
      ),

      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
          color: secondaryTextColor,
        ),
        iconColor: secondaryTextColor,
        border: InputBorder.none,
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      //-----------------------------------

      appBarTheme: AppBarTheme(
        titleTextStyle: defaultTextStyle.copyWith(
            fontSize: 18, color: primaryTextColor, fontWeight: FontWeight.w400),
        elevation: 0,
        backgroundColor: primaryColor,
        foregroundColor: primaryTextColor,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: primaryColor,

            //  Status bar brightness (optional)
            statusBarIconBrightness:
                Brightness.light, // For Android (dark icons)
            statusBarBrightness: Brightness.light,
            systemNavigationBarColor: primaryColor,
            systemNavigationBarIconBrightness:
                Brightness.light // For iOS (dark icons)
            ),
      ),
      //-----------------------------------
      snackBarTheme: SnackBarThemeData(
        contentTextStyle: defaultTextStyle.apply(color: Colors.white),
      ),
      //-----------------------------------
      textTheme: TextTheme(
        titleLarge: defaultTextStyle.copyWith(
            fontSize: 16, color: primaryTextColor, fontWeight: FontWeight.w600),
        titleMedium: defaultTextStyle.copyWith(
            fontSize: 16, color: primaryTextColor, fontWeight: FontWeight.w300),
        titleSmall: defaultTextStyle.copyWith(
            fontSize: 16,
            color: secondaryTextColor,
            fontWeight: FontWeight.w400),
        labelSmall: defaultTextStyle.copyWith(
            fontSize: 14,
            color: secondaryTextColor,
            fontWeight: FontWeight.w400),
        headlineLarge: defaultTextStyle.copyWith(
            fontSize: 30, color: primaryTextColor, fontWeight: FontWeight.bold),
        labelLarge: defaultTextStyle.copyWith(
            fontSize: 24, color: primaryTextColor, fontWeight: FontWeight.w500),
      ),
      //-----------------------------------

      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,

      progressIndicatorTheme: ProgressIndicatorThemeData(
          refreshBackgroundColor: primaryColor.withBlue(35)),
      colorScheme: ColorScheme.dark(
          primary: primaryTextColor,
          onPrimary: primaryTextColor,
          secondary: secondaryColor,
          onSecondary: secondaryTextColor,
          background: Colors.white,
          surface: secondaryTextColor.withOpacity(0.5),
          onSurface: primaryTextColor,
          onBackground: onbackground),
      //-----------------------------------
      useMaterial3: true,
    );
  }
}
