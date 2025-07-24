import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vpn_app/core/constants/color_constants.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorConstants.primaryBlue,
      brightness: Brightness.light,
      surface: ColorConstants.backgroundLight,
    ),
    scaffoldBackgroundColor: ColorConstants.backgroundLight,
    fontFamily: 'Gilroy',

    appBarTheme: AppBarTheme(
      backgroundColor: ColorConstants.backgroundLight,
      elevation: 2,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        color: ColorConstants.textDark,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'Gilroy',
      ),
      iconTheme: IconThemeData(color: ColorConstants.textDark),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    ),

    cardTheme: CardThemeData(
      color: ColorConstants.surfaceLight,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      shadowColor: Colors.black.withValues(alpha: 0.08),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorConstants.primaryBlue,
        foregroundColor: ColorConstants.textWhite,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Gilroy',
        ),
      ),
    ),

    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: ColorConstants.textDark,
        fontSize: 32,
        fontWeight: FontWeight.w700,
        fontFamily: 'Gilroy',
      ),
      displayMedium: TextStyle(
        color: ColorConstants.textDark,
        fontSize: 28,
        fontWeight: FontWeight.w600,
        fontFamily: 'Gilroy',
      ),
      displaySmall: TextStyle(
        color: ColorConstants.textDark,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        fontFamily: 'Gilroy',
      ),
      headlineLarge: TextStyle(
        color: ColorConstants.textDark,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'Gilroy',
      ),
      headlineMedium: TextStyle(
        color: ColorConstants.textDark,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: 'Gilroy',
      ),
      headlineSmall: TextStyle(
        color: ColorConstants.textDark,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFamily: 'Gilroy',
      ),
      bodyLarge: TextStyle(
        color: ColorConstants.textDark,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: 'Gilroy',
      ),
      bodyMedium: TextStyle(
        color: ColorConstants.textGray,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: 'Gilroy',
      ),
      bodySmall: TextStyle(
        color: ColorConstants.textLight,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontFamily: 'Gilroy',
      ),
      labelLarge: TextStyle(
        color: ColorConstants.textDark,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontFamily: 'Gilroy',
      ),
      titleMedium: TextStyle(
        color: ColorConstants.textDark,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: 'Gilroy',
      ),
      titleSmall: TextStyle(
        color: ColorConstants.textDark,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        fontFamily: 'Gilroy',
      ),
      titleLarge: TextStyle(
        color: ColorConstants.textDark,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFamily: 'Gilroy',
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorConstants.surfaceLight,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: ColorConstants.primaryBlue,
          width: 2,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorConstants.primaryBlue,
      brightness: Brightness.dark,
      surface: ColorConstants.surfaceDark,
    ),
    scaffoldBackgroundColor: ColorConstants.backgroundDark,
    fontFamily: 'Gilroy',

    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: ColorConstants.backgroundDark,
      elevation: 2,
      scrolledUnderElevation: 0,
      titleTextStyle: TextStyle(
        color: ColorConstants.textWhite,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'Gilroy',
      ),
      iconTheme: IconThemeData(color: ColorConstants.textWhite),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: ColorConstants.surfaceDark,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      shadowColor: Colors.black.withValues(alpha: 0.3),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorConstants.primaryBlue,
        foregroundColor: ColorConstants.textWhite,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontFamily: 'Gilroy',
        ),
      ),
    ),

    // Text Theme
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: ColorConstants.textWhite,
        fontSize: 32,
        fontWeight: FontWeight.w700,
        fontFamily: 'Gilroy',
      ),
      displayMedium: TextStyle(
        color: ColorConstants.textWhite,
        fontSize: 28,
        fontWeight: FontWeight.w600,
        fontFamily: 'Gilroy',
      ),
      displaySmall: TextStyle(
        color: ColorConstants.textWhite,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        fontFamily: 'Gilroy',
      ),
      headlineLarge: TextStyle(
        color: ColorConstants.textWhite,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'Gilroy',
      ),
      headlineMedium: TextStyle(
        color: ColorConstants.textWhite,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        fontFamily: 'Gilroy',
      ),
      headlineSmall: TextStyle(
        color: ColorConstants.textWhite,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFamily: 'Gilroy',
      ),
      bodyLarge: TextStyle(
        color: ColorConstants.textWhite,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        fontFamily: 'Gilroy',
      ),
      bodyMedium: TextStyle(
        color: ColorConstants.textLight,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: 'Gilroy',
      ),
      bodySmall: TextStyle(
        color: ColorConstants.textLight,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        fontFamily: 'Gilroy',
      ),
      labelLarge: TextStyle(
        color: ColorConstants.textWhite,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        fontFamily: 'Gilroy',
      ),
      titleMedium: TextStyle(
        color: ColorConstants.textWhite,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        fontFamily: 'Gilroy',
      ),
      titleSmall: TextStyle(
        color: ColorConstants.textWhite,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        fontFamily: 'Gilroy',
      ),
      titleLarge: TextStyle(
        color: ColorConstants.textWhite,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        fontFamily: 'Gilroy',
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorConstants.surfaceDark,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade600),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade600),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: ColorConstants.primaryBlue,
          width: 2,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
  );
}
