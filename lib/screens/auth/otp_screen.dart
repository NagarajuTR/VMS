import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:visitors_management/screens/custom_widget/custom_text.dart';
import 'package:visitors_management/screens/dashboard/dashboard.dart';

class OTPScreen extends StatefulWidget {
  final String number;

  const OTPScreen({super.key, required this.number});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _formKey = GlobalKey<FormState>();
  String verificationIdentity = '';
  bool isSubmit = false;
  String otpCode = '';
  String otpOne = "",
      otpTwo = "",
      otpThree = "",
      otpFour = "",
      otpFive = "",
      otpSix = "";

  @override
  void initState() {
    startTimer();
    getOtp(widget.number);
    super.initState();
  }

  @override
  Future<void> dispose() async {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppBar(
              title: const CustomText(
                  text: 'OTP',
                  textSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  color: Colors.black87),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
              centerTitle: true,
              elevation: 0,
            ),
            const Divider(
              thickness: 2,
            )
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                SvgPicture.asset(
                  "assets/svg/otp.svg",
                  height: 200,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: CustomText(
                      text: 'Verification code',
                      textSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      color: Colors.black87),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: CustomText(
                    text:
                        'We are sending the verification code to Your Mobile Number',
                    textSize: 16,
                    letterSpacing: 1,
                    color: Colors.black54,
                    textAlign: TextAlign.center,
                    height: 1.5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: widget.number,
                        textSize: 22,
                        letterSpacing: 3,
                        color: Colors.cyan.shade900,
                        textAlign: TextAlign.center,
                        height: 1.5,
                        fontWeight: FontWeight.bold,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                            shape: const CircleBorder(),
                            backgroundColor: Colors.deepOrangeAccent),
                        child: const Icon(Icons.edit, color: Colors.white),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 100,
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Visibility(
                          visible: !isSubmit,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: CustomText(
                              text: '00 : $_start',
                              textSize: 18,
                              letterSpacing: 3,
                              color: Colors.cyan.shade900,
                              height: 1.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 40.0),
                        /* SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isSubmit
                                  ? Colors.green
                                  : Colors.blueGrey.shade300,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              if (isSubmit) {
                                const CircularProgressIndicator();
                                verifyPhoneNumber(
                                    context: context, otp: otpCode);
                              }
                            },
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Nunito'),
                            ),
                          ),
                        ),*/
                      ],
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const Dashboard()),
                          ModalRoute.withName('/'));
                    },
                    child: Text(
                      "Home",
                      style: TextStyle(fontSize: ConstSize.instance.text24),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> verifyPhoneNumber({context, otp}) async {
    // try {
    //   PhoneAuthService authentication = PhoneAuthService();
    //   FirebaseAuth auth = FirebaseAuth.instance;
    //
    //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
    //       verificationId: verificationIdentity, smsCode: otp);
    //   User? user = (await auth.signInWithCredential(credential)).user;
    //   if (user != null) {
    //     authentication.addUser(context);
    //   }
    // } catch (e) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //         content: Text(
    //       'Invalid OTP',
    //       style: TextStyle(fontFamily: 'Nunito'),
    //     )),
    //   );
    //   print('Error ${e.toString()}');
    // }
  }

  Future<void> getOtp(String number) async {
    // try {
    //   await FirebaseAuth.instance.verifyPhoneNumber(
    //     phoneNumber: number,
    //     verificationCompleted: (PhoneAuthCredential credential) {},
    //     verificationFailed: (FirebaseAuthException e) {
    //       if (e.code == 'invalid-phone-number') {
    //         Navigator.pop(context);
    //         ScaffoldMessenger.of(context).showSnackBar(
    //           const SnackBar(
    //               content: Text('Invalid Phone Number',
    //                   style: TextStyle(fontFamily: 'Nunito'))),
    //         );
    //       }
    //       print('The Error is ${e.code}');
    //     },
    //     codeSent: (String verificationId, int? resendToken) async {
    //       verificationIdentity = verificationId;
    //     },
    //     timeout: const Duration(seconds: 60),
    //     codeAutoRetrievalTimeout: (String verificationId) {},
    //   );
    // } catch (e) {
    //   print('Error ${e.toString()}');
    // }
  }

  late Timer _timer;
  int _start = 60;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
}
