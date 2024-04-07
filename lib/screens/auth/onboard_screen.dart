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
              Expanded(child: Image.asset("assets/svg/onboard.png")),
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  children: [
                    CustomTextSpan.instance.customTextSpan(
                        text: "Join Bechdo, ",
                        color: Colors.white,
                        textSize: ConstSize.instance.header,
                        fontWeight: FontWeight.bold),
                    CustomTextSpan.instance.customTextSpan(
                        text: "Discover Endless Benefits!",
                        color: Colors.white,
                        textSize: ConstSize.instance.header),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomText(
                text:
                    'Step into a vibrant community of buyers and sellers, where endless benefits await. Join us to discover great deals, declutter your space, and connect with others for a seamless marketplace experience.',
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
