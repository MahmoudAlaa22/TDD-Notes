import 'package:flutter/material.dart';
import 'colors.dart';

class AppThemes {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    primaryColorLight: AppColors.primary,
    primaryColorDark: AppColors.primary,
    colorScheme: ThemeData().colorScheme.copyWith(
          secondary: AppColors.primary,
        ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      titleTextStyle: TextStyle(
        color: AppColors.white,
      ),
      actionsIconTheme: IconThemeData(
        color: AppColors.white,
      ),
    ),
    scaffoldBackgroundColor: AppColors.white,
    iconTheme: const IconThemeData(
      color: AppColors.primary,
    ),
    textTheme: const TextTheme(
      headlineMedium:
          TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(
        color: AppColors.black,
      ),
    ),
    primaryIconTheme: const IconThemeData(color: AppColors.primary),
    //? InputDecoration
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(15),
      // hint style
      hintStyle: const TextStyle(color: AppColors.gray),
      // label style
      labelStyle: const TextStyle(color: AppColors.gray),
      // error style
      errorStyle: const TextStyle(color: AppColors.error),
      errorMaxLines: 3,
      prefixIconColor: AppColors.gray,
      suffixIconColor: AppColors.gray,
      border: InputBorder.none,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.gray)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.gray)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error)),

      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.gray)),
    ),
    //? TextButton
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
      overlayColor: MaterialStatePropertyAll<Color>(
        AppColors.primary.withOpacity(0.1),
      ),
    )),
    elevatedButtonTheme: const ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(
        AppColors.primary,
      )),
    ),
     
  );
}
