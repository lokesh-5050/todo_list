import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:todo/core/theme/colors.dart';

/// Defines app theme including text themes.
class ApplicationTheme {
  static ThemeData getAppThemeData() => ThemeData(
        useMaterial3: true,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.transparent),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: backgroundAppBarColor,
        hintColor: limedAshColor,
        primarySwatch: primarySwatchColor,
        splashColor: whiteColor,
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: whiteColor,
          shadowColor: whiteColor
        ),
        primaryColorDark: darkBlackColor,
        scaffoldBackgroundColor: whiteColor,
        // cardColor: lightGreyColor,
        iconTheme: const IconThemeData(color: iconColor),
        appBarTheme: const AppBarTheme(backgroundColor: whiteColor),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: primaryTextColor,
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontSize: 30.sp,
            fontWeight: FontWeight.w500,
            color: darkBlackColor,
            fontFamily: 'Roboto',
          ),
          headlineMedium: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.w300,
              color: darkBlackColor,
              letterSpacing: 1.5,
              fontFamily: 'Roboto'),
          headlineSmall: TextStyle(
            fontSize: 26.sp,
            fontWeight: FontWeight.w400,
            color: darkBlackColor,
            fontFamily: 'Roboto',
          ),
          titleLarge: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: darkBlackColor,
              fontFamily: 'Roboto'),
          titleMedium: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w300,
              color: darkBlackColor,
              fontFamily: 'Roboto'),
          titleSmall: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w400,
              color: whiteColor,
              fontFamily: 'Roboto'),
          bodyLarge: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: darkBlackColor,
              fontFamily: 'Roboto'),
          bodySmall: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w300,
              color: unratedStarFillColor,
              fontFamily: 'Roboto'),
          bodyMedium: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w300,
              color: darkBlackColor,
              fontFamily: 'Roboto'),
          labelLarge: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: backgroundBottomAppBarColor,
              fontFamily: 'Roboto'),
          labelMedium: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: whiteColor,
              fontFamily: 'Roboto'),
          labelSmall: TextStyle(
              fontSize: 8.sp,
              fontWeight: FontWeight.w300,
              color: backgroundBottomAppBarColor,
              fontFamily: 'Roboto'),
        ),
      );
}
