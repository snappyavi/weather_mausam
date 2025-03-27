import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/screens/home_screen.dart'; // Import your main screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _preloadLottie();
    // Simulate loading time or perform initial setup.
    _navigateToHome();
  }

  Future<void> _preloadLottie() async {
    // Preload the Lottie asset
    await precacheLottie(AssetLottie('assets/sunsplash.json'), context);
  }

  _navigateToHome() async {
    // Simulate a delay (e.g., loading data, checking authentication).
    await Future.delayed(const Duration(milliseconds: 3800));

    // Navigate to your main screen.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ), // Replace with your main screen widget
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
            // Add your app logo or image here.
            Lottie.asset(
              'assets/sunsplash.json',
              height: 250,
              width: 250,
            ),
          //  const SizedBox(height: 20),
           Text(
              'Mausam',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent,
              ),
            ),
            //  const SizedBox(height: 20),
            // const LinearProgressIndicator(color: Colors.white), // Optional loading indicator
          ],
        ),
      ),
    );
  }
}
Future<void> precacheLottie(AssetLottie lottie, BuildContext context) async {
  await lottie.load();
}