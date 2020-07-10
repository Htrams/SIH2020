import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sih2020/components/vehicle.dart';

class VehicleListScreen extends StatefulWidget {
  static String screenID = 'vehicle_list_screen';
  @override
  _VehicleListScreenState createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends State<VehicleListScreen> {

  List<Vehicle> vehicleList = <Vehicle>[
    Vehicle(
      carName: 'MG Hector',
      lastTravelled: '16 hours ago'
    ),
    Vehicle(
      carName: 'Swift',
      lastTravelled: 'Yesterday'
    ),
    Vehicle(
      carName: 'Nixon',
      lastTravelled: '10 days ago'
    ),
    Vehicle(),
    Vehicle()
  ];

  int selectedVehicle = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0)
        ),
        elevation: 5.0,
        centerTitle: true,
        title: Text(
          'Vehicles',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25.0
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child: Icon(
          FontAwesomeIcons.plus
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(10.0),
        itemCount: vehicleList.length,
        itemBuilder: (context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedVehicle = index;
              });
            },
            child: vehicleList[index].getVehicleAsListItem(
              selected: index==selectedVehicle
            )
          );
        },
        separatorBuilder: (context,int index) {
          return Divider();
        },
      ),
    );
  }
}
