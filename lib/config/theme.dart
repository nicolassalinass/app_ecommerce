import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(
      primary: Colors.blue,
      secondary: Colors.lightBlueAccent,
      onPrimary: Colors.white,
      seedColor: Colors.white, 
      brightness: Brightness.light
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      shape: Border(bottom: BorderSide(color: Colors.grey.shade300, width: 1)),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      indicatorColor: const Color.fromARGB(255, 49, 144, 253),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: Colors.white);
        }
        return IconThemeData(color: Colors.black);
      }),
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      labelTextStyle: WidgetStatePropertyAll(
        TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      shadowColor: Colors.grey.shade200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      elevation: 0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.black, fontSize: 16),
      filled: true,
      fillColor: Colors.grey.shade200,
      // border: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(10),
      //   borderSide: BorderSide.none,
      // ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide.none,
      ),
      prefixIconColor: Colors.grey.shade700,
      hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      side: BorderSide(color: Colors.grey.shade200),
      shape: StadiumBorder(),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      selectedColor: Colors.blueAccent[400],
      secondaryLabelStyle: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      //secondarySelectedColor: Colors.grey.shade700,
      brightness: Brightness.dark,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.black,
    colorScheme: ColorScheme.dark(
      primary: Colors.blue,
      secondary: Colors.lightBlueAccent,
      onPrimary: Colors.white,
      surface: Color(0xFF1E1E1E),
      brightness: Brightness.dark,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black,
      shape: Border(bottom: BorderSide(color: Colors.grey.shade400, width: 1)),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.black,
      indicatorColor: Colors.grey.shade800,
      surfaceTintColor: Colors.transparent,
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: Colors.blueAccent);
        }
        return IconThemeData(color: Colors.white);
      }),
      labelTextStyle: WidgetStatePropertyAll(
        TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
      filled: true,
      fillColor: Colors.grey.shade900,
      // border: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(10),
      //   borderSide: BorderSide.none,
      // ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide.none,
      ),
      prefixIconColor: Colors.grey,
      hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
    ),
    chipTheme: ChipThemeData(
      //backgroundColor: Colors.grey.shade800,
      labelStyle: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
      side: BorderSide(color: Colors.grey.shade800),
      shape: StadiumBorder(),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      selectedColor: Colors.grey.shade800,
      //secondarySelectedColor: Colors.grey.shade700,
      brightness: Brightness.dark,
    ),
  );
}
