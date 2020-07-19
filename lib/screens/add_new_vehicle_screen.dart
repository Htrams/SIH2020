import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sih2020/components/vehicle.dart';

class NewVehicleScreen extends StatefulWidget {
  @override
  _NewVehicleScreenState createState() => _NewVehicleScreenState();
}

class _NewVehicleScreenState extends State<NewVehicleScreen> {
  String carName;
  double mileage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text(
            'Add new vehicle'
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              if (carName == null) {
                print('Please type a car name. ');
              }
              else{
                Navigator.pop(
                    context,
                    Vehicle(
                      carName: carName,
                    )
                );
              }
            },
            child: Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(
                  FontAwesomeIcons.carAlt
              ),
              title: TextField(
                cursorColor: Colors.green,
                decoration: InputDecoration(
                    hintText: "Vehicle name",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 19,
                    )
                ),
                style: TextStyle(

                ),
                textAlign: TextAlign.start,
                onChanged: (String value) {
                  carName = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

