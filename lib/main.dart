import 'package:challenge/coffe_challenge/coffe_challenge.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            textTheme: GoogleFonts.robotoCondensedTextTheme()),
        home: const CoffeChallenge());
  }
}
