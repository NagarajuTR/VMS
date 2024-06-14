import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:visitors_management/const/colors_const.dart';
import 'package:visitors_management/const/constants.dart';
import 'package:visitors_management/screens/custom_widget/custom_text.dart';
import 'package:visitors_management/screens/home/main_screen.dart';

class VisitorsList extends StatefulWidget {
  const VisitorsList({super.key});

  @override
  State<StatefulWidget> createState() => _Dashboard();
}

class _Dashboard extends State<VisitorsList> {
  final Stream<QuerySnapshot> _employees =
      FirebaseFirestore.instance.collection('visitors').snapshots();

  @override
  Widget build(BuildContext context) {
    return MainScreen(
      appBar: AppBar(
        title: const Text(
          "Visitors",
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
                text: 'Visitors list',
                textSize: ConstSize.instance.text24,
                color: ColorsConst.instance.blue,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(height: 5),
              const Divider(),
              const SizedBox(height: 5),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _employees,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.active) {
                      List<Map<String, dynamic>?>? documentData = snapshot
                          .data?.docs
                          .map((e) => e.data() as Map<String, dynamic>?)
                          .toList();

                      return ListView.separated(
                        itemCount: documentData?.length ?? 0,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> employee =
                              documentData?[index] as Map<String, dynamic>;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(48),
                                      border: Border.all(
                                          width: 3,
                                          color: ColorsConst.instance.blue)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: CachedNetworkImage(
                                      imageUrl: Constants.instance.imageUrl,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        width: 100.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      progressIndicatorBuilder: (context, url,
                                              downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Wrap(
                                  direction: Axis.vertical,
                                  children: [
                                    CustomText(
                                      text: '${employee['name']}',
                                      textSize: ConstSize.instance.text24,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    CustomText(
                                      text: '${employee['email']}',
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
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
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
