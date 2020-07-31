import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sih2020/screens/red_screen.dart';

class DestinationScreen extends StatefulWidget {
  @override
  _DestinationScreenState createState() => _DestinationScreenState();
  static String screenID = 'destination_screen';
}

class _DestinationScreenState extends State<DestinationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        title: Text(
            'ENTER DESTINATION',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 23.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RedScreen.screenID);
        },
        child: Icon(
          FontAwesomeIcons.arrowRight
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                Icon(
                  Icons.gps_fixed,
                  size: 25.0,
                  color: Colors.blue,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Text(
                      'Current Location',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                )
              ],
            ),
            TextField(
              decoration: InputDecoration(
                hintText: "Where to?",
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0.0)),
                  borderSide: BorderSide(
                    color: Colors.blue.shade600,
                  ),
                ),
              ),
            ),

              Text(
                'or',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20.0,
                ),
              ),

             FlatButton.icon(
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                onPressed: () {
                  print('hey');
                },
                icon: Icon(Icons.edit_location, color: Colors.white,),
                label: Text(
                  'Select From Map',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                color: Colors.blue,
              ),
            SizedBox(
              height: 10.0,
            ),
            Hero(
              tag: 'appLogo',
              child: Icon(
                Icons.local_gas_station,
                size: 100.0,
                color: Colors.blue.shade200,
              ),
            ),
            Text(
              'Fuelio',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}