// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isResendAgain = false;

  bool isVerified = false;

  bool isLoading = false;

  String code = '';

  late Timer timer;
  int start = 60;
  //////////////////////////////////////////
  void resend() {
    setState(() {
      isResendAgain = true;
    });

    timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        setState(() {
          if (start == 0) {
            isResendAgain = false;
            start = 60;
            timer.cancel();
          } else {
            start--;
          }
        });
      },
    );
  }

  void verify() {
    setState(() {
      isLoading = true;
    });
    timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        isLoading = false;
        isVerified = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: double.infinity,
          padding: EdgeInsets.all(12),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  height: size.height * .22,
                  width: size.height * .22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade200,
                  ),
                  child: Transform.rotate(
                    angle: 38,
                    child: Image.asset('assets/email.png'),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.08,
                ),
                Text(
                  "Verification",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Text(
                  'please enter the 6 digiy code sent to\n+20 1020579624',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade500,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Center(
                  child: VerificationCode(
                    length: 6,
                    textStyle: TextStyle(fontSize: 20),
                    underlineColor: Colors.blueAccent,
                    keyboardType: TextInputType.number,
                    onCompleted: (value) {
                      code = value;
                    },
                    onEditing: (value) {},
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Dont't resive the OTP?",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (isResendAgain) return;
                        resend();
                      },
                      child: Text(
                        isResendAgain == true
                            ? "Try again in " + start.toString()
                            : 'Resend',
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                MaterialButton(
                  disabledColor: Colors.grey.shade300,
                  onPressed: code.length < 6
                      ? null
                      : () {
                          verify();
                        },
                  height: size.height * 0.05,
                  minWidth: size.width * 0.05,
                  color: Colors.black,
                  child: isLoading
                      ? Container(
                          height: size.height * 0.02,
                          width: size.width * 0.02,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.black,
                            strokeAlign: 3,
                            color: Colors.black,
                          ),
                        )
                      : isVerified
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 35,
                            )
                          : Text(
                              "Verify",
                              style: TextStyle(color: Colors.white),
                            ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
