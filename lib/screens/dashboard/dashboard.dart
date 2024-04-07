import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:visitors_management/const/colors_const.dart';
import 'package:visitors_management/screens/custom_widget/custom_text.dart';
import 'package:visitors_management/screens/home/main_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<StatefulWidget> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Visitors List',
                textSize: ConstSize.instance.text24,
                color: ColorsConst.instance.blue,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(height: 5),
              const Divider(),
              const SizedBox(height: 5),
              Expanded(
                child: ListView.separated(
                  itemCount: 5,
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
                                text: DateFormat('dd/MM/yyyy hh:mm a')
                                    .format(DateTime.now()),
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
            ],
          ),
        ),
      ),
    );
  }
}
