// import 'dart:ui';

// import 'package:flutter/material.dart';

// class LightThemeColors {
//   static const primaryColor = Color(0xffFFFFFF);
//   static const secondaryColor = Color(0xffB8B8B8);
//   static const primaryTextColor = Color(0xff000000);
//   static const secondaryTextColor = Color(0xffA0A0A0);
//   static const onbackground = Color(0xffF2F2F2);
// }

// class DarkThemeColors {
//   static const primaryColor = Color(0xff0D0D0D);
//   static const secondaryColor = Color(0xffB8B8B8);
//   static const primaryTextColor = Color(0xffFFFFFF);
//   static const secondaryTextColor = Color(0xffA0A0A0);
//   static const onbackground = Color(0xff1A1A1A);
// }

// class MyAppThemeConfig {
//   final Color primaryColor;
//   final Color secondaryColor;
//   final Color primaryTextColor;
//   final Color secondaryTextColor;
//   final Color onbackground;

//   MyAppThemeConfig.dark()
//       : primaryColor = DarkThemeColors.primaryColor,
//         secondaryColor = DarkThemeColors.secondaryColor,
//         primaryTextColor = DarkThemeColors.primaryTextColor,
//         secondaryTextColor = DarkThemeColors.secondaryTextColor,
//         onbackground = DarkThemeColors.onbackground;

//   MyAppThemeConfig.light()
//       : primaryColor = LightThemeColors.primaryColor,
//         secondaryColor = LightThemeColors.secondaryColor,
//         primaryTextColor = LightThemeColors.primaryTextColor,
//         secondaryTextColor = LightThemeColors.secondaryTextColor,
//         onbackground = LightThemeColors.onbackground;
//   ThemeData getTheme() {
//     final defaultTextStyle =
//         TextStyle(fontFamily: 'Shabnam', color: primaryTextColor);
//     return ThemeData(
//       //-----------------------------------

//       scaffoldBackgroundColor: primaryColor,

//       outlinedButtonTheme: OutlinedButtonThemeData(
//         style: ButtonStyle(
//             side: MaterialStateProperty.all(BorderSide(
//           color: secondaryTextColor.withOpacity(0.8),
//           width: 1,
//         ))),
//       ),

//       inputDecorationTheme: InputDecorationTheme(
//         labelStyle: TextStyle(
//           color: secondaryTextColor,
//         ),
//         iconColor: secondaryTextColor,
//         border: InputBorder.none,
//         floatingLabelBehavior: FloatingLabelBehavior.never,
//       ),
//       //-----------------------------------

//       appBarTheme: AppBarTheme(
//           elevation: 0,
//           backgroundColor: primaryColor,
//           foregroundColor: primaryTextColor),
//       //-----------------------------------
//       snackBarTheme: SnackBarThemeData(
//         contentTextStyle: defaultTextStyle.apply(color: Colors.white),
//       ),
//       //-----------------------------------
//       textTheme: TextTheme(
//         subtitle1: defaultTextStyle.copyWith(
//             color: secondaryTextColor,
//             fontSize: 17,
//             fontWeight: FontWeight.w400),
//         button: defaultTextStyle,
//         bodyText2: defaultTextStyle,
//         caption: defaultTextStyle.apply(color: secondaryTextColor),
//         headline6: defaultTextStyle.copyWith(
//             fontWeight: FontWeight.w700, fontSize: 18),
//       ),
//       //-----------------------------------
//       colorScheme: ColorScheme.light(

//           primary: primaryTextColor,
//           onPrimary: primaryTextColor,
//           secondary: secondaryColor,
//           onSecondary: secondaryTextColor,
//          // background: Colors.white,
//           onBackground: onbackground),
//       //-----------------------------------
//       //   useMaterial3: true,
//     );
//   }
// }

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class LightThemeColors {
  static const primaryColor = Color(0xffFFFFFF);
  static const secondaryColor = Color(0xffacacac);
  static const primaryTextColor = Color(0xff000000);
  static const secondaryTextColor = Color(0xffa0a0a0);
  static const onbackground = Color(0xfff5f5f5);
}

class DarkThemeColors {
  static const primaryColor = Color(0xff101010);
  static const secondaryColor = Color(0xff585858);
  static const primaryTextColor = Color(0xffFFFFFF);
  static const secondaryTextColor = Color(0xffB8B8B8);
  static const onbackground = Color(0xff1e1e1e);
}

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
        // bodyLarge: TextStyle(
        //      color: primaryTextColor,
        //    fontWeight: FontWeight.w600,
        // ),

        //  bodyLarge: defaultTextStyle.copyWith(
        //   color: primaryTextColor,
        //   fontWeight: FontWeight.w600
        // ),
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

        labelLarge: defaultTextStyle.copyWith(
            fontSize: 24, color: primaryTextColor, fontWeight: FontWeight.w500),

        //////////////////////////
        // subtitle1: defaultTextStyle.copyWith(
        //     color: secondaryTextColor,
        //     fontSize: 17,
        //     fontWeight: FontWeight.w400),
        // button: defaultTextStyle,
        // bodyText2: defaultTextStyle,
        // caption: defaultTextStyle.apply(color: secondaryTextColor),
        // headline6: defaultTextStyle.copyWith(
        //     fontWeight: FontWeight.w700, fontSize: 18),
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

        labelLarge: defaultTextStyle.copyWith(
            fontSize: 24, color: primaryTextColor, fontWeight: FontWeight.w500),

        // subtitle1: defaultTextStyle.copyWith(
        //     color: secondaryTextColor,
        //     fontSize: 17,
        //     fontWeight: FontWeight.w400),
        // button: defaultTextStyle,
        // bodyText2: defaultTextStyle,
        // caption: defaultTextStyle.apply(color: secondaryTextColor),
        // headline6: defaultTextStyle.copyWith(
        //     fontWeight: FontWeight.w700, fontSize: 18),
      ),
      //-----------------------------------
      bottomNavigationBarTheme: BottomNavigationBarThemeData(),

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
          onBackground: onbackground),
      //-----------------------------------
      useMaterial3: true,
    );
  }
}
