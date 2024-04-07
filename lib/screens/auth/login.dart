import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:visitors_management/screens/custom_widget/custom_text.dart';
import 'package:visitors_management/screens/custom_widget/custom_textform_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<Login> {
  bool enableLogin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            const CustomText(
              text: 'Login',
              textSize: 24,
            ),
            const CustomText(
              text: 'We will send you one-time-password to your mobile number.',
              color: Colors.grey,
            ),
            Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: CustomTextFormField(
                    hintText: "+91",
                  ),
                ),
                const SizedBox(
                  width: 1,
                ),
                Expanded(
                  flex: 5,
                  child: CustomTextFormField(
                    hintText: "Enter your phone number",
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      setState(() {
                        if (value.length == 10) {
                          enableLogin = true;
                        } else {
                          enableLogin = false;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Spacer(),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: 'Terms & Conditions & Privacy Policies',
                  decoration: TextDecoration.underline,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const Login()));
                },
                child: SvgPicture.asset('assets/svg/verify_disabled_btn.svg')),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
