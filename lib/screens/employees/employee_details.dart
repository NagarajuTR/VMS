import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:visitors_management/const/colors_const.dart';
import 'package:visitors_management/screens/custom_widget/custom_text.dart';
import 'package:visitors_management/screens/home/main_screen.dart';

class EmployeeDetails extends StatefulWidget {
  final Map<String, dynamic> employee;

  const EmployeeDetails({super.key, required this.employee});

  @override
  State<StatefulWidget> createState() => _EmployeeDetailsState();
}

class _EmployeeDetailsState extends State<EmployeeDetails> {
  @override
  Widget build(BuildContext context) {
    return MainScreen(
      appBar: AppBar(
        title: const Text(
          "Employee details",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: ColorsConst.instance.blue,
        centerTitle: true,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(75),
                  border:
                      Border.all(width: 3, color: ColorsConst.instance.blue)),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: CachedNetworkImage(
                  imageUrl: widget.employee['imageUrl'] ?? "",
                  imageBuilder: (context, imageProvider) => Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(
                          value: downloadProgress.progress),
                  errorWidget: (context, url, error) => const Icon(Icons.error,
                      size: 150, color: Colors.blueGrey),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          flex: 2,
                          child: CustomText(
                            text: "Name: ",
                            textAlign: TextAlign.end,
                            textSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 4,
                          child: CustomText(
                            text: "${widget.employee['name'] ?? ""}",
                            textSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          flex: 2,
                          child: CustomText(
                            text: "Employee ID: ",
                            textAlign: TextAlign.end,
                            textSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 4,
                          child: CustomText(
                            text: "${widget.employee['employeeId'] ?? ""}",
                            textSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          flex: 2,
                          child: CustomText(
                            text: "Email: ",
                            textAlign: TextAlign.end,
                            textSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 4,
                          child: CustomText(
                            text: "${widget.employee['email'] ?? ""}",
                            textSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          flex: 2,
                          child: CustomText(
                            text: "Phone number: ",
                            textAlign: TextAlign.end,
                            textSize: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 4,
                          child: CustomText(
                            text: "${widget.employee['phone'] ?? ""}",
                            textSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
