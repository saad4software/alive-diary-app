import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTheme {

  static ThemeData get light {
    return ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          elevation: 8,
          backgroundColor: Color(0xFF86338F),
          surfaceTintColor: Color(0xFF86338F),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          actionsIconTheme: IconThemeData(color: Colors.white),
        ),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFF86338F),
        splashColor: Colors.transparent,
        fontFamily: "IBM",
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.white,
        ),

        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: GoogleFonts.openSans(
            fontSize: 30,
            fontStyle: FontStyle.italic,
          ),
          bodyMedium: GoogleFonts.openSans(),
          displaySmall: GoogleFonts.openSans(),

        )
    );
  }


  static TextStyle get textHeader {
    return const TextStyle(
      fontSize: 20,
      color: Color(0xFF000000),
      fontWeight: FontWeight.bold
    );
  }

  static TextStyle get textBody {
    return const TextStyle(
      fontSize: 14,
    );
  }
}