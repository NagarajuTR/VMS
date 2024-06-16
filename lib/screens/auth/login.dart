import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visitors_management/const/colors_const.dart';
import 'package:visitors_management/screens/custom_widget/custom_grdient_button.dart';
import 'package:visitors_management/screens/custom_widget/custom_text.dart';
import 'package:visitors_management/screens/custom_widget/custom_textform_field.dart';
import 'package:visitors_management/screens/custom_widget/gradient_background.dart';
import 'package:visitors_management/screens/dashboard/dashboard.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends State<Login> {
  String phone = "";
  String password = "";

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        colors: [ColorsConst.instance.yellow, ColorsConst.instance.orange],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const CustomText(
                  text: 'Login',
                  textSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    CustomTextFormField(
                      hintText: "Enter your phone number",
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
                      hintText: "Enter password",
                      keyboardType: TextInputType.phone,
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
                  height: 15,
                ),
                CustomGradientButton(
                  onPressed: () {
                    verifyLogin();
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ConstSize.instance.textLarge,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> verifyLogin() async {
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

      QuerySnapshot<Map<String, dynamic>> employees = await FirebaseFirestore
          .instance
          .collection('employees')
          .where('phone', isEqualTo: phone)
          .where('password', isEqualTo: password)
          .get();

      if (employees.docs.isNotEmpty) {
        Map<String, dynamic> employee = employees.docs.first.data();
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("employee", jsonEncode(employee));

        if (!mounted) return;

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const Dashboard()),
            ModalRoute.withName('/'));

        _formKey.currentState?.reset();

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login successfully..!')));
      } else {
        if (!mounted) return;
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Please enter valid phone number and password.')));
      }
    }
  }
}
