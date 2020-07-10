import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Vehicle {

  final String carName;
  final String lastTravelled;
  final IconData icon;

  Vehicle({
    this.carName = 'Car',
    this.lastTravelled,
    this.icon = FontAwesomeIcons.car,
  });

  Widget getVehicleAsListItem({bool selected = false}) {
    return Card(
      color: selected ? Color(0xff369df7) : Colors.white,
      elevation: selected ? 5.0 : 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13.0),
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Icon(
                icon,
                color: Colors.lightGreen.shade400,
                size: 40.0,
              ),
            ),
          ),
          SizedBox(
            width: 8.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                '$carName',
                style: TextStyle(
                  fontSize: 32.0,
                  color: selected ? Colors.white : Colors.black
                ),
              ),
              Text(
                'Last Travelled - $lastTravelled',
                style: TextStyle(
                  fontSize: 18.0,
                  color: selected ? Colors.white : Colors.grey.shade600
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}