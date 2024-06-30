import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:visitors_management/const/colors_const.dart';
import 'package:visitors_management/screens/custom_widget/custom_grdient_button.dart';
import 'package:visitors_management/screens/custom_widget/custom_text.dart';
import 'package:visitors_management/screens/custom_widget/custom_textform_field.dart';
import 'package:visitors_management/screens/employees/employees.dart';
import 'package:visitors_management/screens/employees/employees_home.dart';
import 'package:visitors_management/screens/home/main_screen.dart';

class EditEmployee extends StatefulWidget {
  final Map<String, dynamic> employee;

  const EditEmployee({super.key, required this.employee});

  @override
  State<StatefulWidget> createState() => _EditEmployeeState();
}

class _EditEmployeeState extends State<EditEmployee> {
  final _formKey = GlobalKey<FormState>();
  XFile? imageFile;
  final ImagePicker _picker = ImagePicker();

  CollectionReference employees =
      FirebaseFirestore.instance.collection('employees');

  String name = "";
  String email = "";
  String phone = "";
  String designation = "";
  String password = "";
  String employeeId = "";
  String imageUrl = "";
  String docId = "";

  @override
  void initState() {
    name = widget.employee['name'];
    email = widget.employee['email'];
    phone = widget.employee['phone'];
    designation = widget.employee['designation'];
    password = widget.employee['password'];
    employeeId = widget.employee['employeeId'];
    imageUrl = widget.employee['imageUrl'];
    docId = widget.employee['id'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen(
      appBar: AppBar(
        title: const Text(
          "Add employee",
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
                  onTap: () async {
                    await showPickerBottomSheet();
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
                            : CachedNetworkImage(
                                imageUrl: widget.employee['imageUrl'] ?? "",
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  width: 150.0,
                                  height: 150.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        CircularProgressIndicator(
                                            value: downloadProgress.progress),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error,
                                        size: 150, color: Colors.blueGrey),
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
                      initialValue: name,
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
                      label: "Employee id",
                      hintText: "Employee id",
                      initialValue: employeeId,
                      onChanged: (value) {
                        employeeId = value;
                      },
                      validator: (value) {
                        return (value ?? '').isEmpty
                            ? 'Employee id can\'t be empty'
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
                      initialValue: email,
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
                      initialValue: phone,
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
                      label: "Designation",
                      hintText: "Designation",
                      initialValue: designation,
                      onChanged: (value) {
                        designation = value;
                      },
                      validator: (value) {
                        return (value ?? '').isEmpty
                            ? 'Designation can\'t be empty'
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
                      label: "Password",
                      hintText: "Password",
                      initialValue: password,
                      onChanged: (value) {
                        password = value;
                      },
                      validator: (value) {
                        return (value ?? '').isEmpty
                            ? 'Password can\'t be empty'
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
                    editEmployeeData();
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

  Future<void> showPickerBottomSheet() async {
    await showModalBottomSheet<void>(
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
                    onTap: () async {
                      await _onImageButtonPressed(ImageSource.camera, context);
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
                    onTap: () async {
                      await _onImageButtonPressed(ImageSource.gallery, context);
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

  editEmployeeData() async {
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState?.save();

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

        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('employees')
            .where('phone', isEqualTo: phone)
            .get();

        if (querySnapshot.docs.isNotEmpty &&
            (querySnapshot.docs.first.data()
                    as Map<String, dynamic>)['phone'] !=
                widget.employee['phone'] &&
            mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Phone number already exists!')),
          );
          Navigator.of(context).pop();

          return;
        }

        if (imageFile != null) {
          final file = File(imageFile?.path ?? '');

          String imageName =
              "employee_${DateTime.now().millisecondsSinceEpoch}.jpg";

          Reference ref =
              FirebaseStorage.instance.ref().child('images').child(imageName);
          UploadTask uploadTask = ref.putFile(file);
          final snapshot = await uploadTask.whenComplete(() => null);

          imageUrl = await snapshot.ref.getDownloadURL();

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

        await employees.doc(docId).update({
          'name': name,
          'email': email,
          'phone': phone,
          'designation': designation,
          'password': password,
          'employeeId': employeeId,
          'imageUrl': imageUrl,
          'updatedAt': Timestamp.now()
        });

        _formKey.currentState?.reset();

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Employee data saved successfully..!')),
        );

        Navigator.of(context).pop();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Employees(),
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
          builder: (context) => const EmployeesHome(),
        ),
      );
    }
  }
}
