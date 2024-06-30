import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visitors_management/const/colors_const.dart';
import 'package:visitors_management/model/employee.dart';
import 'package:visitors_management/screens/auth/login.dart';
import 'package:visitors_management/screens/custom_widget/custom_text.dart';
import 'package:visitors_management/screens/custom_widget/gradient_background.dart';
import 'package:visitors_management/screens/dashboard/dashboard.dart';
import 'package:visitors_management/screens/home/main_screen.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<StatefulWidget> createState() => _Dashboard();
}

class _Dashboard extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Dashboard()),
          (Route<dynamic> route) => false,
        );
        return Future.value(false);
      },
      child: MainScreen(
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
                          // Image.asset(
                          //   'assets/png/profile.png',
                          //   height: 100,
                          //   width: 100,
                          // ),

                          CachedNetworkImage(
                            imageUrl:
                                Employee.instance.employee['imageUrl'] ?? "",
                            imageBuilder: (context, imageProvider) => Container(
                              width: 80.0,
                              height: 80.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        value: downloadProgress.progress),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.error,
                              size: 80,
                              color: Colors.blueGrey,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Wrap(
                            direction: Axis.vertical,
                            children: [
                              CustomText(
                                text:
                                    '${Employee.instance.employee['name'] ?? ''}',
                                textSize: ConstSize.instance.text24,
                              ),
                              CustomText(
                                text: '${Employee.instance.employee['email']}',
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
                          await prefs.clear();

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
      ),
    );
  }
}
