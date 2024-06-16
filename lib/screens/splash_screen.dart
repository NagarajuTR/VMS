import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visitors_management/model/employee.dart';
import 'package:visitors_management/screens/auth/onboard_screen.dart';
import 'package:visitors_management/screens/custom_widget/gradient_background.dart';
import 'package:visitors_management/screens/dashboard/dashboard.dart';

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
    await Future.delayed(const Duration(seconds: 1));

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String employeeString = prefs.getString("employee") ?? '';
    if (!mounted) return;

    if (employeeString.isNotEmpty) {
      Employee.instance.employee = jsonDecode(employeeString);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const Dashboard()),
          ModalRoute.withName(
            '/',
          ));
      return;
    }

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => const OnboardScreen()),
        ModalRoute.withName('/'));
  }
}
