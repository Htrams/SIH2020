import 'package:flutter/material.dart';
import 'package:sih2020/screens/registration_screen.dart';
import 'package:sih2020/screens/vehicle_list_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/destination_screen.dart';
import 'screens/red_screen.dart';
import 'screens/review_screen.dart';

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
        RegistrationScreen.screenID:(context) => RegistrationScreen(),
        VehicleListScreen.screenID:(context) => VehicleListScreen(),
        DestinationScreen.screenID:(context) => DestinationScreen(),
        RedScreen.screenID:(context) => RedScreen(),
        ReviewScreen.screenID:(context) => ReviewScreen()
      },
    );
  }
}
