import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

ThemeData buildAppTheme() {
  final base = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.light(
      primary: AppColors.blue,
      onPrimary: Colors.white,
      secondary: AppColors.green,
      onSecondary: Colors.white,
      surface: AppColors.surface,
      onSurface: AppColors.text,
    ),
    dividerColor: AppColors.border,
  );
  final textTheme = GoogleFonts.tajawalTextTheme(base.textTheme)
      .apply(bodyColor: AppColors.text, displayColor: AppColors.navy);

  return base.copyWith(
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: AppColors.navy,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: textTheme.titleLarge?.copyWith(
        color: AppColors.navy,
        fontWeight: FontWeight.w900,
        fontSize: 22,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.surface,
      indicatorColor: AppColors.greenLight,
      height: 72,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      indicatorShape: const StadiumBorder(),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        final selected = states.contains(WidgetState.selected);
        return textTheme.labelMedium?.copyWith(
          fontSize: 12,
          fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          color: selected ? AppColors.green : AppColors.muted,
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        final selected = states.contains(WidgetState.selected);
        return IconThemeData(
          color: selected ? AppColors.green : AppColors.muted,
        );
      }),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.navy,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentTextStyle: textTheme.bodyMedium?.copyWith(color: Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      labelStyle: textTheme.bodyMedium?.copyWith(color: AppColors.muted),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.blue, width: 1.4),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFB42318)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFB42318)),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.blue,
        foregroundColor: Colors.white,
        textStyle: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
        shape: const StadiumBorder(),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.blue,
        side: const BorderSide(color: AppColors.blue, width: 1.3),
        textStyle: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
        shape: const StadiumBorder(),
      ),
    ),
    chipTheme: base.chipTheme.copyWith(
      selectedColor: AppColors.greenLight,
      backgroundColor: AppColors.surface,
      side: const BorderSide(color: AppColors.border),
      labelStyle: textTheme.labelLarge?.copyWith(color: AppColors.blue),
      secondaryLabelStyle: textTheme.labelLarge?.copyWith(
        color: AppColors.blue,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
