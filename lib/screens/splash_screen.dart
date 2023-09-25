import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const String appName = 'Flashcard';
final String copyright = '${getCurrentYear()} \u00a9 Poralcode';

int getCurrentYear() {
  return DateTime.now().year;
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive); //this remove the top and bottom bar making the app full screen.
    // Initialize data before showing the main screen: Fetch list of flashcard items from a database.
    Future.delayed(const Duration(seconds: 15), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  /* This is supposed to getrid of the full screen after showing the splash screen. But there might be a performance issue so we don't use this anymore. */
  /*@override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('lib/assets/logo.png'),
              width: 200,
              height: 200,
            ),
            Text(
              appName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'study on your terms',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          copyright,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
