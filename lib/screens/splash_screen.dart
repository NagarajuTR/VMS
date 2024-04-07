import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    return GradientBackground(
      child: Center(
        child: SvgPicture.asset("assets/svg/splash_logo.svg"),
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
