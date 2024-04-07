import 'package:flutter/material.dart';
import 'package:visitors_management/screens/auth/onboard_screen.dart';
import 'package:visitors_management/screens/custom_widget/gradient_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    initiateNavigation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const GradientBackground(
      child: Center(
        child: Icon(
          Icons.handshake,
          color: Colors.white,
          size: 140,
        ),
      ),
    );
  }

  Future<void> initiateNavigation() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const OnboardScreen()));
  }
}
