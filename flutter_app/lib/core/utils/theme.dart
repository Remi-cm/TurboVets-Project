import 'package:flutter/material.dart';

import 'colors.dart';
import 'constants.dart';

ThemeData appTheme(BuildContext context, bool isDark) {
  String font = font1;
  String titleFont = font1;
  TextTheme textTheme(TextTheme base) {
    return !isDark ? base.copyWith(
        displayLarge: base.displayLarge?.copyWith(fontFamily: font, fontSize: 22.0, fontWeight: FontWeight.w500, color: Colors.black87),
        displayMedium: base.displayMedium?.copyWith(fontFamily: font, fontSize: 20.0, fontWeight: FontWeight.w700, color: textColor),
        displaySmall: base.displaySmall?.copyWith(fontFamily: font, fontSize: 16, fontWeight: FontWeight.w400, color: darkCardColor),
        headlineMedium: base.displayLarge?.copyWith(fontFamily: titleFont, fontSize: 20.0, fontWeight: FontWeight.w500, color: textColor),
        headlineSmall: base.headlineSmall?.copyWith(color: Theme.of(context).hintColor, fontFamily: font1, fontWeight: FontWeight.w400, fontSize: 11),
        titleLarge: base.headlineSmall?.copyWith(fontFamily: titleFont, fontSize: 16.0, fontWeight: FontWeight.w500, color: textColor),
        bodySmall: base.bodySmall?.copyWith(fontFamily: font, fontSize: 14, color: textColor),
        bodyLarge: base.bodyLarge?.copyWith(fontFamily: font, color: textColor),
        bodyMedium: base.bodyMedium?.copyWith(fontFamily: font, fontWeight: FontWeight.w400, color: textColor, fontSize: 12), // TextStyle in whole app
        titleMedium: base.headlineSmall?.copyWith(fontFamily: font1, fontSize: 27, height: 1, letterSpacing: -2, color: textColor, fontWeight: FontWeight.w700),
        titleSmall: base.headlineSmall?.copyWith(fontFamily: titleFont, fontSize: 14, fontWeight: FontWeight.w600, color: textColor),
        labelLarge: base.labelLarge?.copyWith(color: bgColor)
    )
        : base.copyWith(
      displayLarge: base.displayLarge?.copyWith(fontFamily: titleFont, fontSize: 22.0, fontWeight: FontWeight.w500, color: textColorDark),
      displayMedium: base.displayMedium?.copyWith(fontFamily: font, fontSize: 20.0, fontWeight: FontWeight.w500, color: textColorDark),
      displaySmall: base.displaySmall?.copyWith(fontFamily: font, fontSize: 16, fontWeight: FontWeight.w500, color: textColorDark),
      headlineMedium: base.displayLarge?.copyWith(fontFamily: titleFont, fontSize: 20.0, fontWeight: FontWeight.w500, color: textColorDark),
      headlineSmall: base.headlineSmall?.copyWith(color: Colors.grey[300], fontFamily: font1, fontWeight: FontWeight.w400, fontSize: 11),
      titleLarge: base.headlineSmall?.copyWith(fontFamily: titleFont, fontSize: 16.0, fontWeight: FontWeight.w500, color: textColorDark),
      bodySmall: base.bodySmall?.copyWith(fontFamily: font, color: textColorDark),
      bodyLarge: base.bodyLarge?.copyWith(fontFamily: font, color: textColorDark),
      bodyMedium: base.bodyMedium?.copyWith(fontFamily: font, color: textColorDark, fontSize: 12.5),  // TextStyle
      titleMedium:base.headlineSmall?.copyWith(fontFamily: font1, fontSize: 27, letterSpacing: -2, height: 1, color: textColorDark, fontWeight: FontWeight.w700),
      titleSmall: base.headlineSmall?.copyWith(fontFamily: titleFont, fontSize: 14, fontWeight: FontWeight.w600, color: textColorDark),
    );
  }

  final ThemeData lightTheme = ThemeData.light();
  final ThemeData darkTheme = ThemeData.dark();



  return !isDark ? lightTheme.copyWith(

    textTheme: textTheme(lightTheme.textTheme),
    cardColor: Color(0xffF0F5E8),
    secondaryHeaderColor: bgColorDark,
    hoverColor: lightBgGrey,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: bgColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    listTileTheme: ThemeData.light().listTileTheme.copyWith(
        titleTextStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: textColor, fontFamily: titleFont),
        subtitleTextStyle: TextStyle(fontSize: 13, color: Colors.grey[600], fontFamily: font)
    ),
    appBarTheme: ThemeData.light().appBarTheme.copyWith(
        surfaceTintColor: Colors.transparent,
        backgroundColor: bgColor,
        centerTitle: true,
        elevation: 0,
        titleTextStyle: TextStyle(color: bgColorDark, letterSpacing: -1, fontSize: 19, fontWeight: FontWeight.w700, fontFamily: titleFont),
        iconTheme: IconThemeData(color: Colors.grey[700], size: 30)
    ),

    iconTheme: const IconThemeData(color: textColor, size: 30),
    buttonTheme: lightTheme.buttonTheme.copyWith(buttonColor: textColor),
    colorScheme: ThemeData.light().colorScheme.copyWith(primary: primaryColor, secondary: primaryColor, tertiary: primaryColor).copyWith(error: Colors.red).copyWith(surface: Colors.white),
    hintColor: greyColor,
    dividerColor: lightLineColor,
    dividerTheme: ThemeData.light().dividerTheme.copyWith(color: lightLineColor),
    floatingActionButtonTheme: ThemeData.light().floatingActionButtonTheme.copyWith(iconSize: 40),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      },
    ),
  )
      : darkTheme.copyWith(
    secondaryHeaderColor: bgColor,
    cardColor: darkCardColor,
    hoverColor: Colors.grey[900],
    textSelectionTheme: ThemeData.dark().textSelectionTheme.copyWith(cursorColor: Colors.grey[200]),
    textTheme: textTheme(darkTheme.textTheme),
    colorScheme: ThemeData.dark().colorScheme.copyWith(primary: primaryColor, secondary: primaryColor, tertiary: primaryColor),
    appBarTheme: ThemeData.dark().appBarTheme.copyWith(
        surfaceTintColor: Colors.transparent,
        backgroundColor: bgColorDark,
        centerTitle: true,
        elevation: 0,
        titleTextStyle: TextStyle(color: Colors.grey[100], fontSize: 19, fontWeight: FontWeight.w700, letterSpacing: -1, fontFamily: titleFont),
        iconTheme: IconThemeData(color: Colors.grey[100], size: 30)
    ),
    listTileTheme: ThemeData.dark().listTileTheme.copyWith(
        iconColor: whiteColor,
        titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: textColorDark, fontFamily: titleFont),
        subtitleTextStyle: TextStyle(fontSize: 13, color: Colors.grey[600], fontFamily: font)
    ),
    iconTheme: const IconThemeData(color: textColorDark, size: 30),
    primaryColor: primaryColor,
    scaffoldBackgroundColor: bgColorDark,
    dividerColor: Colors.grey[800],
    hintColor: Colors.grey[500],
    floatingActionButtonTheme: ThemeData.dark().floatingActionButtonTheme.copyWith(foregroundColor: Colors.black, backgroundColor: whiteColor),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

}