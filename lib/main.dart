import 'package:flutter/material.dart';
import 'package:sih2020/screens/registration_screen.dart';
import 'welcome_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.screenID,
      routes: {
        WelcomeScreen.screenID :(context) => WelcomeScreen(),
        LoginScreen.screenID:(context) => LoginScreen(),
        RegistrationScreen.screenID:(context) => RegistrationScreen()
      },
    );
  }
}
