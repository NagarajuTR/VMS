import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:visitors_management/const/colors_const.dart';
import 'package:visitors_management/screens/custom_widget/custom_grdient_button.dart';
import 'package:visitors_management/screens/custom_widget/custom_text.dart';
import 'package:visitors_management/screens/custom_widget/gradient_background.dart';
import 'package:visitors_management/screens/dashboard/visitors_list.dart';
import 'package:visitors_management/screens/home/main_screen.dart';
import 'package:visitors_management/screens/visitors/add_visitor.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<StatefulWidget> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  int todayVisitors = 0;
  int totalVisitors = 0;
  late final StreamSubscription<QuerySnapshot> todayVisitorsSubscription;
  late final StreamSubscription<QuerySnapshot> totalVisitorsSubscription;

  @override
  void initState() {
    super.initState();
    DateTime today = DateTime.now();
    DateTime startOfDay = DateTime(today.year, today.month, today.day);
    DateTime endOfDay = startOfDay.add(const Duration(days: 1));

    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('visitors');

    todayVisitorsSubscription = collectionRef
        .where('visitTime', isGreaterThanOrEqualTo: startOfDay)
        .where('visitTime', isLessThan: endOfDay)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      setState(() {
        todayVisitors = snapshot.docs.length;
      });
    });

    totalVisitorsSubscription =
        collectionRef.snapshots().listen((QuerySnapshot snapshot) {
      setState(() {
        totalVisitors = snapshot.docs.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen(
      appBar: AppBar(
        title: const Text(
          "Dashboard",
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
                      const CustomText(text: "Add new visitor"),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomGradientButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddVisitor(),
                            ),
                          );
                        },
                        child: const CustomText(
                          text: "ADD NEW VISITOR",
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
                        text: "TODAY'S VISITORS",
                        fontWeight: FontWeight.bold,
                        textSize: ConstSize.instance.textLarge,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomText(
                          text:
                              "Today's total number of visitors: ${todayVisitors.toString()}"),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomGradientButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const VisitorsList(isTodayList: true),
                            ),
                          );
                        },
                        child: const CustomText(
                          text: "VIEW TODAY'S VISITORS",
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
                        text: "VISITORS",
                        fontWeight: FontWeight.bold,
                        textSize: ConstSize.instance.textLarge,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomText(
                          text:
                              "Total number of visitors: ${totalVisitors.toString()}"),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomGradientButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const VisitorsList(),
                            ),
                          );
                        },
                        child: const CustomText(
                          text: "VIEW ALL VISITORS",
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
    );
  }

  @override
  void dispose() {
    todayVisitorsSubscription.cancel();
    totalVisitorsSubscription.cancel();
    super.dispose();
  }
}
