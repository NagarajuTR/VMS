import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:visitors_management/const/colors_const.dart';
import 'package:visitors_management/screens/custom_widget/custom_grdient_button.dart';
import 'package:visitors_management/screens/custom_widget/custom_text.dart';
import 'package:visitors_management/screens/custom_widget/custom_textform_field.dart';
import 'package:visitors_management/screens/home/main_screen.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({super.key});

  @override
  State<StatefulWidget> createState() => _AddVisitor();
}

class _AddVisitor extends State<AddEmployee> {
  final _formKey = GlobalKey<FormState>();
  XFile? imageFile;
  final ImagePicker _picker = ImagePicker();

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
                            : CachedNetworkImage(
                                imageUrl: "http://via.placeholder.com/350x150",
                                placeholder: (context, url) =>
                                    const CircleAvatar(
                                  backgroundColor: Colors.white30,
                                ),
                                errorWidget: (context, url, error) => Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: Image.asset(
                                    'assets/images/noImage.png',
                                    height: 110,
                                    // width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                imageBuilder: (context, image) => Image(
                                  image: image,
                                  height: 110,
                                  fit: BoxFit.fitWidth,
                                ),
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
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {},
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
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {},
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
                      onChanged: (value) {},
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
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {},
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomGradientButton(
                  onPressed: () {},
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
      } catch (e) {}
    }
  }
}
