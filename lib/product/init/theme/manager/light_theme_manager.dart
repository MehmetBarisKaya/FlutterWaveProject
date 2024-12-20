import 'package:flutter/material.dart';
import 'package:flutter_bootcamp_project/product/init/theme/colors/custom_color_scheme.dart';
import 'package:flutter_bootcamp_project/product/init/theme/interface/custom_theme.dart';
import 'package:google_fonts/google_fonts.dart';

final class LightThemeManager implements CustomTheme {
  @override
  ThemeData get themeData => ThemeData(
      useMaterial3: true,
      fontFamily: GoogleFonts.openSans().fontFamily,
      colorScheme: CustomColorScheme.lightColorScheme,
      appBarTheme: const AppBarTheme(
        centerTitle: false,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        enableFeedback: true,
        elevation: 3,
      ),
      inputDecorationTheme: InputDecorationTheme());
}
