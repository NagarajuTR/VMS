import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:visitors_management/const/colors_const.dart';
import 'package:visitors_management/screens/custom_widget/custom_text.dart';
import 'package:visitors_management/screens/custom_widget/custom_textform_field.dart';
import 'package:visitors_management/screens/home/main_screen.dart';

class VisitorsList extends StatefulWidget {
  const VisitorsList({super.key});

  @override
  State<StatefulWidget> createState() => _VisitorsListState();
}

class _VisitorsListState extends State<VisitorsList> {
  @override
  Widget build(BuildContext context) {
    return MainScreen(
        appBar: AppBar(
          title: const Text(
            "Visitors List",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: ColorsConst.instance.blue,
          centerTitle: true,
        ),
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  CustomTextFormField(
                    hintText: "Search visitor",
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.separated(
                  itemCount: 25,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(42),
                                border: Border.all(
                                    width: 3,
                                    color: ColorsConst.instance.blue)),
                            child: const Icon(
                              Icons.account_circle_outlined,
                              size: 60,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Wrap(
                            direction: Axis.vertical,
                            children: [
                              CustomText(
                                text: 'Arun yadav',
                                textSize: ConstSize.instance.text24,
                                fontWeight: FontWeight.w500,
                              ),
                              CustomText(
                                text: 'arunyadav@gmail.com',
                                textSize: ConstSize.instance.textLarge,
                              ),
                              CustomText(
                                text: DateFormat('dd/MM/yyyy hh:mm a').format(
                                  DateTime.now().add(
                                    Duration(
                                        days: index,
                                        hours: index,
                                        minutes: index),
                                  ),
                                ),
                                textSize: ConstSize.instance.textLarge,
                              )
                            ],
                          ),
                          const Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: ColorsConst.instance.blue,
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
