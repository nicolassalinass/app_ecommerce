import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(
      primary: Colors.blue.shade800,
      secondary: const Color.fromARGB(255, 215, 237, 255),
      onPrimary: Colors.white,
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
    scaffoldBackgroundColor: Color(0xFF0B132B),
    colorScheme: ColorScheme.dark(
      primary: Colors.blue,
      secondary: const Color(0xFF162553),
      onPrimary: Colors.white,
      //background: const Color(0xFF0B132B),,
      //surface: Color(0xFF1E1E1E),
      surface: Color(0xFF0B132B),
      brightness: Brightness.dark,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF0B132B),
      shape: Border(bottom: BorderSide(color: Colors.grey.shade400, width: 1)),
    ),
    // bottomAppBarTheme: BottomAppBarThemeData(
    //   //height: 80,
    //   //shape: CircularNotchedRectangle(),
    //   //elevation: 8,
    // ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Color(0xFF0B132B),
      //indicatorColor: Colors.grey.shade800,
      indicatorColor: Color.fromARGB(255, 31, 33, 54),
      surfaceTintColor: Colors.transparent,
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: Colors.blueAccent);
        }
        return IconThemeData(color: Colors.grey.shade400);
      }),
      labelTextStyle: WidgetStatePropertyAll(
        TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
      filled: true,
      //fillColor: Colors.grey.shade900,
      fillColor: Color.fromARGB(255, 31, 33, 54),
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
      selectedColor: Colors.blueAccent,
      //secondarySelectedColor: Colors.grey.shade700,
      brightness: Brightness.dark,
    ),
    cardTheme: CardThemeData(
      color: Color.fromARGB(255, 31, 33, 54),
      shadowColor: Colors.grey.shade200,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        //side: BorderSide(color: Colors.blue),
      ),
      elevation: 0,
    ),
  );
}
