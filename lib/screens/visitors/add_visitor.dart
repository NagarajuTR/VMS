import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:visitors_management/const/colors_const.dart';
import 'package:visitors_management/screens/custom_widget/custom_grdient_button.dart';
import 'package:visitors_management/screens/custom_widget/custom_text.dart';
import 'package:visitors_management/screens/custom_widget/custom_textform_field.dart';
import 'package:visitors_management/screens/dashboard/visitors_list.dart';
import 'package:visitors_management/screens/home/main_screen.dart';

import '../dashboard/dashboard.dart';

class AddVisitor extends StatefulWidget {
  const AddVisitor({super.key});

  @override
  State<StatefulWidget> createState() => _AddVisitor();
}

class _AddVisitor extends State<AddVisitor> {
  final _formKey = GlobalKey<FormState>();
  XFile? imageFile;
  final ImagePicker _picker = ImagePicker();

  CollectionReference visitors =
      FirebaseFirestore.instance.collection('visitors');

  String name = "";
  String email = "";
  String phone = "";
  String company = "";
  String purpose = "";
  String belongings = "";
  String visitTime = "";

  @override
  Widget build(BuildContext context) {
    return MainScreen(
      appBar: AppBar(
        title: const Text(
          "Add visitor",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: ColorsConst.instance.blue,
        centerTitle: true,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    showPickerBottomSheet();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.deepOrange.shade400,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black38)),
                    child: ClipOval(
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(60),
                        child: (imageFile?.path != null)
                            ? Image.file(
                                File(imageFile?.path ?? ''),
                                fit: BoxFit.cover,
                              )
                            : const Icon(
                                Icons.person,
                                size: 100,
                                color: Colors.white,
                              ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    CustomTextFormField(
                      label: "Enter name",
                      hintText: "Enter name",
                      onChanged: (value) {
                        name = value;
                      },
                      validator: (value) {
                        return (value ?? '').isEmpty
                            ? 'Name can\'t be empty'
                            : null;
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    CustomTextFormField(
                      label: "Enter email",
                      hintText: "Enter email",
                      onChanged: (value) {
                        email = value;
                      },
                      validator: (value) {
                        if ((value ?? '').isEmpty) {
                          return 'Email can\'t be empty';
                        }

                        if (!RegExp(
                                r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                            .hasMatch(value ?? "")) {
                          return "Enter valid email";
                        }

                        return null;
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    CustomTextFormField(
                      label: "Enter phone number",
                      hintText: "Enter phone number",
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        phone = value;
                      },
                      validator: (value) {
                        if ((value ?? '').isEmpty) {
                          return 'Phone number can\'t be empty';
                        }

                        if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                            .hasMatch(value ?? "")) {
                          return "Enter valid phone number";
                        }

                        return null;
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    CustomTextFormField(
                      label: "Enter company name",
                      hintText: "Enter company name",
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        company = value;
                      },
                      validator: (value) {
                        return (value ?? '').isEmpty
                            ? 'Company name can\'t be empty'
                            : null;
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    CustomTextFormField(
                      label: "Purpose of visit",
                      hintText: "Purpose of visit",
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        purpose = value;
                      },
                      validator: (value) {
                        return (value ?? '').isEmpty
                            ? 'Enter purpose of visit'
                            : null;
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    CustomTextFormField(
                      label: "Belongings",
                      hintText: "Belongings",
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        belongings = value;
                      },
                      validator: (value) {
                        return (value ?? '').isEmpty
                            ? 'Enter belongings'
                            : null;
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    CustomTextFormField(
                      label: "Visit time",
                      hintText: "Visit time",
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        visitTime = value;
                      },
                      validator: (value) {
                        return (value ?? '').isEmpty
                            ? 'Enter visit time'
                            : null;
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomGradientButton(
                  onPressed: () {
                    saveVisitorData();
                  },
                  child: const CustomText(
                    text: "SAVE",
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showPickerBottomSheet() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 250,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomText(
                text: "Select image source",
                textSize: ConstSize.instance.text24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      _onImageButtonPressed(ImageSource.camera, context);
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade400,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.camera_alt_outlined,
                            size: 50,
                            color: Colors.white,
                          ),
                          CustomText(
                            text: "Camera",
                            textSize: ConstSize.instance.textLarge,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _onImageButtonPressed(ImageSource.gallery, context);
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade400,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.photo_library_outlined,
                            size: 50,
                            color: Colors.white,
                          ),
                          CustomText(
                            text: "Gallery",
                            textSize: ConstSize.instance.textLarge,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _onImageButtonPressed(
      ImageSource source, BuildContext context) async {
    if (context.mounted) {
      try {
        final XFile? pickedFile = await _picker.pickImage(source: source);
        setState(() {
          imageFile = pickedFile;
        });
        Navigator.of(context).pop();
      } catch (e) {}
    }
  }

  saveVisitorData() async {
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState?.save();

        String imageName =
            "visitor_${DateTime.now().millisecondsSinceEpoch}.jpg";

        if (imageFile == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please select profile image')),
          );
          return;
        } else {
          final file = File(imageFile?.path ?? '');

          final metadata = SettableMetadata(contentType: "image/jpeg");

          final storageRef = FirebaseStorage.instance.ref();

          final uploadTask =
              storageRef.child("images/$imageName").putFile(file, metadata);

          uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
            switch (taskSnapshot.state) {
              case TaskState.running:
                final progress = 100.0 *
                    (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
                print("Upload is $progress% complete.");
                break;
              case TaskState.paused:
                print("Upload is paused.");
                break;
              case TaskState.canceled:
                print("Upload was canceled");
                break;
              case TaskState.error:
                // Handle unsuccessful uploads
                break;
              case TaskState.success:
                // Handle successful uploads on complete
                // ...
                break;
            }
          });
        }

        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const Dialog(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(left: 4.0),
                      child: CustomText(
                          text: "Processing...",
                          textSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            );
          },
        );

        await visitors.add({
          'name': name, // John Doe
          'email': email, // Stokes and Sons
          'phone': phone,
          'company': company,
          'purpose': purpose,
          'belongings': belongings,
          'visitTime': visitTime
        });

        _formKey.currentState?.reset();

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Visitor data saved successfully..!')),
        );

        Navigator.of(context).pop();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const VisitorsList(),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Something went wrong. Please try again later..!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Dashboard(),
        ),
      );
    }
  }
}
