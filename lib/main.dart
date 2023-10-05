import 'package:flashcard/models/flashcard_provider.dart';
import 'package:flutter/material.dart';
import 'package:flashcard/theme/color_schemes.g.dart';
import 'package:flashcard/screens/home_screen.dart';
import 'package:flashcard/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FlashcardProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flashcard', // Capitalize the first letter
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      home: const SplashScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
