import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppRadius {
  static const double card = 24.0;
  static const double cardSmall = 16.0;
  static const double button = 16.0;
  static const double pill = 32.0;
  static const double input = 14.0;
  
  static final BorderRadius cardRadius = BorderRadius.circular(card);
  static final BorderRadius cardSmallRadius = BorderRadius.circular(cardSmall);
  static final BorderRadius buttonRadius = BorderRadius.circular(button);
  static final BorderRadius pillRadius = BorderRadius.circular(pill);
  static final BorderRadius inputRadius = BorderRadius.circular(input);
}

class AppColors {
  // Deep Navy Dark Palette
  static const Color darkBackground = Color(0xFF0F111E);
  static const Color darkSidebar = Color(0xFF141727);
  static const Color darkCard = Color(0xFF191D32);
  static const Color darkCardInner = Color(0xFF20253F);
  static const Color darkBorder = Color(0xFF282E4D);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFF8E95AF);
  
  // Vibrant Coral Accent Palette
  static const Color vibrantCoral = Color(0xFFFF6452);
  static const Color vibrantCoralHover = Color(0xFFFF7A6B);
  static const Color coralGradientEnd = Color(0xFFFF8E53);
  
  // Secondary Neon / Fintech Accents
  static const Color neonBlue = Color(0xFF00C6FF);
  static const Color deepBlue = Color(0xFF0072FF);
  static const Color vividPurple = Color(0xFFA855F7);
  static const Color electricCyan = Color(0xFF06B6D4);
  static const Color successGreen = Color(0xFF10B981);
  static const Color warningRed = Color(0xFFF43F5E);
  static const Color goldYellow = Color(0xFFFBBF24);

  // Light Theme Palette
  static const Color lightBackground = Color(0xFFF3F5FA);
  static const Color lightSidebar = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightCardInner = Color(0xFFF8FAFC);
  static const Color lightBorder = Color(0xFFE2E8F0);
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF64748B);
}

class AppTheme {
  static ThemeData get darkTheme {
    final textTheme = GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.vibrantCoral,
        secondary: AppColors.neonBlue,
        tertiary: AppColors.vividPurple,
        surface: AppColors.darkCard,
        surfaceContainerHighest: AppColors.darkCardInner,
        outline: AppColors.darkBorder,
        onPrimary: Colors.white,
        onSurface: AppColors.darkTextPrimary,
        error: AppColors.warningRed,
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.cardRadius,
          side: const BorderSide(color: AppColors.darkBorder, width: 1.2),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.darkBorder,
        thickness: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkCardInner.withValues(alpha: 0.6),
        border: OutlineInputBorder(
          borderRadius: AppRadius.inputRadius,
          borderSide: const BorderSide(color: AppColors.darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.inputRadius,
          borderSide: const BorderSide(color: AppColors.darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.inputRadius,
          borderSide: const BorderSide(color: AppColors.vibrantCoral, width: 1.5),
        ),
        hintStyle: TextStyle(
          color: AppColors.darkTextSecondary.withValues(alpha: 0.7),
          fontSize: 14,
        ),
      ),
      textTheme: textTheme.copyWith(
        headlineMedium: textTheme.headlineMedium?.copyWith(
          color: AppColors.darkTextPrimary,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
        headlineSmall: textTheme.headlineSmall?.copyWith(
          color: AppColors.darkTextPrimary,
          fontWeight: FontWeight.w700,
        ),
        titleLarge: textTheme.titleLarge?.copyWith(
          color: AppColors.darkTextPrimary,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: textTheme.titleMedium?.copyWith(
          color: AppColors.darkTextPrimary,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: textTheme.bodyLarge?.copyWith(
          color: AppColors.darkTextPrimary,
        ),
        bodyMedium: textTheme.bodyMedium?.copyWith(
          color: AppColors.darkTextSecondary,
        ),
        bodySmall: textTheme.bodySmall?.copyWith(
          color: AppColors.darkTextSecondary,
        ),
      ),
    );
  }

  static ThemeData get lightTheme {
    final textTheme = GoogleFonts.outfitTextTheme(ThemeData.light().textTheme);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: const ColorScheme.light(
        primary: AppColors.vibrantCoral,
        secondary: AppColors.deepBlue,
        tertiary: AppColors.vividPurple,
        surface: AppColors.lightCard,
        surfaceContainerHighest: AppColors.lightCardInner,
        outline: AppColors.lightBorder,
        onPrimary: Colors.white,
        onSurface: AppColors.lightTextPrimary,
        error: AppColors.warningRed,
      ),
      cardTheme: CardThemeData(
        color: AppColors.lightCard,
        elevation: 2,
        shadowColor: const Color(0x140F172A),
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.cardRadius,
          side: const BorderSide(color: AppColors.lightBorder, width: 1),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.lightBorder,
        thickness: 1,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightCardInner,
        border: OutlineInputBorder(
          borderRadius: AppRadius.inputRadius,
          borderSide: const BorderSide(color: AppColors.lightBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.inputRadius,
          borderSide: const BorderSide(color: AppColors.lightBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.inputRadius,
          borderSide: const BorderSide(color: AppColors.vibrantCoral, width: 1.5),
        ),
        hintStyle: const TextStyle(
          color: AppColors.lightTextSecondary,
          fontSize: 14,
        ),
      ),
      textTheme: textTheme.copyWith(
        headlineMedium: textTheme.headlineMedium?.copyWith(
          color: AppColors.lightTextPrimary,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
        headlineSmall: textTheme.headlineSmall?.copyWith(
          color: AppColors.lightTextPrimary,
          fontWeight: FontWeight.w700,
        ),
        titleLarge: textTheme.titleLarge?.copyWith(
          color: AppColors.lightTextPrimary,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: textTheme.titleMedium?.copyWith(
          color: AppColors.lightTextPrimary,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: textTheme.bodyLarge?.copyWith(
          color: AppColors.lightTextPrimary,
        ),
        bodyMedium: textTheme.bodyMedium?.copyWith(
          color: AppColors.lightTextSecondary,
        ),
        bodySmall: textTheme.bodySmall?.copyWith(
          color: AppColors.lightTextSecondary,
        ),
      ),
    );
  }
}
