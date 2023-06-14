import 'package:flutter/material.dart';
import 'package:serves/main.dart';
import 'package:serves/screens/welcome_screen.dart';

void main() => runApp(const MyApp());

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Serve Restaurant',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const SplashScreen(),
      routes: {
        '/home': (context) => const WelcomeScreen(),
      },
    );
  }
}
