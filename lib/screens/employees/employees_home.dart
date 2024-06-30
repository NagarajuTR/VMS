import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visitors_management/const/colors_const.dart';
import 'package:visitors_management/provider/bottomnav_index.dart';
import 'package:visitors_management/screens/custom_widget/custom_grdient_button.dart';
import 'package:visitors_management/screens/custom_widget/custom_text.dart';
import 'package:visitors_management/screens/custom_widget/gradient_background.dart';
import 'package:visitors_management/screens/dashboard/dashboard.dart';
import 'package:visitors_management/screens/employees/add_employee.dart';
import 'package:visitors_management/screens/employees/employees.dart';
import 'package:visitors_management/screens/home/main_screen.dart';

class EmployeesHome extends StatefulWidget {
  const EmployeesHome({super.key});

  @override
  State<StatefulWidget> createState() => _Dashboard();
}

class _Dashboard extends State<EmployeesHome> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Provider.of<BottomNavIndex>(context, listen: false)
            .changeIndex(selectedIndex: 0);
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
            "Employees",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: ColorsConst.instance.blue,
          centerTitle: true,
        ),
        child: GradientBackground(
          colors: const [Color(0xFF3333ff), Color(0xFFe6e6e6)],
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 6),
            child: Column(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CustomText(
                          text: "ADD",
                          fontWeight: FontWeight.bold,
                          textSize: ConstSize.instance.textLarge,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const CustomText(text: "Add new employee"),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomGradientButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddEmployee(),
                              ),
                            );
                          },
                          child: const CustomText(
                            text: "ADD NEW EMPLOYEE",
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CustomText(
                          text: "VIEW ALL EMPLOYEES",
                          fontWeight: FontWeight.bold,
                          textSize: ConstSize.instance.textLarge,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const CustomText(
                            text: "View total number of employees"),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomGradientButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Employees(),
                              ),
                            );
                          },
                          child: const CustomText(
                            text: "VIEW EMPLOYEES",
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
