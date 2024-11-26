import 'package:flutter/material.dart';
import 'package:flutter_bootcamp_project/product/init/theme/colors/custom_color_scheme.dart';
import 'package:flutter_bootcamp_project/product/init/theme/interface/custom_theme.dart';

final class DarkThemeManager implements CustomTheme {
  @override
  ThemeData get themeData => ThemeData(
        useMaterial3: true,
        //fontFamily: GoogleFonts.inter().fontFamily,
        colorScheme: CustomColorScheme.darkColorScheme,
        iconTheme: const IconThemeData(color: Colors.white),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          enableFeedback: true,
          elevation: 3,
          selectedIconTheme: IconThemeData(color: Colors.teal),
        ),
      );
}
