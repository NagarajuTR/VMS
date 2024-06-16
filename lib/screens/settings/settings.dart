import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visitors_management/const/colors_const.dart';
import 'package:visitors_management/screens/auth/login.dart';
import 'package:visitors_management/screens/custom_widget/custom_text.dart';
import 'package:visitors_management/screens/custom_widget/gradient_background.dart';
import 'package:visitors_management/screens/home/main_screen.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<StatefulWidget> createState() => _Dashboard();
}

class _Dashboard extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return MainScreen(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: ColorsConst.instance.blue,
        centerTitle: true,
      ),
      child: GradientBackground(
        colors: const [Color(0xFF3333ff), Color(0xFFe6e6e6)],
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'My profile',
                      textSize: ConstSize.instance.text24,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Image.asset(
                          'assets/png/profile.png',
                          height: 100,
                          width: 100,
                        ),
                        const SizedBox(width: 5),
                        Wrap(
                          direction: Axis.vertical,
                          children: [
                            CustomText(
                              text: 'Arun yadav',
                              textSize: ConstSize.instance.text24,
                            ),
                            CustomText(
                              text: 'arunyadav@gmail.com',
                              textSize: ConstSize.instance.textLarge,
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      onTap: () async {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.clear();

                        if (!mounted) return;

                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Login()),
                            ModalRoute.withName('/'));
                      },
                      leading: const Icon(Icons.logout),
                      title: CustomText(
                        text: "Logout",
                        textSize: ConstSize.instance.textLarge,
                      ),
                    )
                  ],
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
