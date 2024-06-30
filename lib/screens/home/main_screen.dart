import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visitors_management/const/colors_const.dart';
import 'package:visitors_management/provider/bottomnav_index.dart';
import 'package:visitors_management/screens/dashboard/dashboard.dart';
import 'package:visitors_management/screens/employees/employees_home.dart';
import 'package:visitors_management/screens/settings/settings.dart';

class MainScreen extends StatefulWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;

  const MainScreen({
    required this.child,
    this.appBar,
    super.key,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBar,
      resizeToAvoidBottomInset: true,
      body: SafeArea(child: widget.child),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            switchScreen(index);
          });
        },
        indicatorColor: ColorsConst.instance.blue,
        selectedIndex:
            Provider.of<BottomNavIndex>(context, listen: true).selectedIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(
              Icons.dashboard,
              color: Colors.white,
            ),
            icon: Icon(Icons.dashboard_outlined),
            label: 'Dashboard',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.people_alt,
              color: Colors.white,
            ),
            icon: Icon(Icons.people_alt_outlined),
            label: 'Employees',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  void switchScreen(int index) {
    Provider.of<BottomNavIndex>(context, listen: false)
        .changeIndex(selectedIndex: index);
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Dashboard(),
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EmployeesHome(),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Settings(),
          ),
        );
        break;
    }
  }
}
