import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:visitors_management/screens/auth/login.dart';
import 'package:visitors_management/screens/custom_widget/custom_text.dart';
import 'package:visitors_management/screens/custom_widget/custom_textspan.dart';
import 'package:visitors_management/screens/custom_widget/gradient_background.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});
  @override
  State<StatefulWidget> createState() => OnboardScreenState();
}

class OnboardScreenState extends State<OnboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const Expanded(
                  child: Icon(
                Icons.handshake,
                color: Colors.white,
                size: 140,
              )),
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  children: [
                    CustomTextSpan.instance.customTextSpan(
                        text: "Visitor's Management System, ",
                        color: Colors.white,
                        textSize: ConstSize.instance.header,
                        fontWeight: FontWeight.bold),
                    CustomTextSpan.instance.customTextSpan(
                        text: "Streamlining Entry and Exit Processes",
                        color: Colors.white,
                        textSize: ConstSize.instance.text24),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomText(
                text:
                    'Enhances security, streamlines check-in/out, and monitors visitor activities efficiently.',
                color: Colors.white,
                textSize: ConstSize.instance.textLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => const Login()));
                  },
                  child: SvgPicture.asset('assets/svg/get_started_btn.svg')),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
