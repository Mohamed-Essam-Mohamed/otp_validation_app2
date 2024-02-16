import 'package:flutter/material.dart';
import 'package:otp_validation_app2/howe_screen.dart';

void main() {
  runApp(OtpApp());
}

class OtpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
      },
    );
  }
}
