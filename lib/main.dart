import 'package:flutter/material.dart';
import 'package:flashcard/screens/home_screen.dart';
import 'package:flashcard/screens/splash_screen.dart';

const String appName = 'Flashcard';
final String copyright = '${getCurrentYear()} \u00a9 Poralcode';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const SplashScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
