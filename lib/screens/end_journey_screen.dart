import 'package:flutter/material.dart';
import 'package:sih2020/components/rounded_button.dart';
import 'package:sih2020/screens/review_screen.dart';

class EndJourneyScreen extends StatefulWidget {
  static String screenID = 'end_journey_screen';
  @override
  _EndJourneyScreenState createState() => _EndJourneyScreenState();
}

class _EndJourneyScreenState extends State<EndJourneyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0,left: 8.0,right: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Journey Completed',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30
                ),
              ),
              SizedBox(
                height: 100.0
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Give your valuable feed...',
                  style: TextStyle(
                    fontSize: 17.0
                  ),
                ),
              ),
              RoundedButton(
                text: 'Rate Petrol Pumps',
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(
                      builder: (context) => ReviewScreen()));
                }
              ),
              RoundedButton(
                  text: 'Exit',
                  onPressed: () {

                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
