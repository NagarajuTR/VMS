import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:visitors_management/const/colors_const.dart';
import 'package:visitors_management/screens/custom_widget/custom_text.dart';
import 'package:visitors_management/screens/home/main_screen.dart';

class VisitorDetails extends StatefulWidget {
  final Map<String, dynamic> visitor;
  const VisitorDetails({super.key, required this.visitor});

  @override
  State<StatefulWidget> createState() => _VisitorDetailsState();
}

class _VisitorDetailsState extends State<VisitorDetails> {
  @override
  Widget build(BuildContext context) {
    return MainScreen(
      appBar: AppBar(
        title: const Text(
          "Visitor details",
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
                  imageUrl: widget.visitor['imageUrl'] ?? "",
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
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error, size: 80, color: Colors.blueGrey),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
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
                    text: "${widget.visitor['name'] ?? ""}",
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
                    text: "${widget.visitor['email'] ?? ""}",
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
                    text: "${widget.visitor['phone'] ?? ""}",
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
                    text: "Purpose of visit: ",
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
                    text: "${widget.visitor['purpose'] ?? ""}",
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
                    text: "Belongings: ",
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
                    text: "${widget.visitor['belongings'] ?? ""}",
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
                    text: "Visit time: ",
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
                    text: "${widget.visitor['visitTime'] ?? ""}",
                    textSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
