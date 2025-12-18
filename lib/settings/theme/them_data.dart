import 'package:flutter/material.dart';


ThemeData appTheme() {
  const primaryGreen = Color(0xFF2EEA8C);
  const backgroundDark = Color(0xFF0E1F17);
  const surfaceDark = Color(0xFF162C22);
  const surfaceVariant = Color(0xFF1A3529);
  const textPrimary = Color(0xFFE8F5EE);
  const textSecondary = Color(0xFF9FB8AC);

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: primaryGreen,
      onPrimary: Colors.black,
      secondary: Color(0xFF1FBF73),
      onSecondary: Colors.black,
      background: backgroundDark,
      onBackground: textPrimary,
      surface: surfaceDark,
      onSurface: textPrimary,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: textSecondary,
      error: Colors.redAccent,
      onError: Colors.black,
    ),

    scaffoldBackgroundColor: backgroundDark,

    appBarTheme: const AppBarTheme(
      backgroundColor: backgroundDark,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: textPrimary,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: textPrimary),
    ),

    cardTheme: CardThemeData(
      color: surfaceDark,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.black,
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: textPrimary,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: textPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: textSecondary,
      ),
    ),

    iconTheme: const IconThemeData(
      color: primaryGreen,
    ),

    dividerTheme: DividerThemeData(
      color: textSecondary.withOpacity(0.2),
    ),
  );
}
