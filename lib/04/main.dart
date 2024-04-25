import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals/04/screens/tabs.dart';

final theme = ThemeData(
    brightness: Brightness.light,
    colorScheme:
        ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 131, 57, 0)),
    textTheme: GoogleFonts.latoTextTheme());

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      theme: theme,
      home: const TabsScreen(),
    );
  }
}
