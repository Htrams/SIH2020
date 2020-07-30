import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sih2020/components/customizable_card.dart';
import 'package:sih2020/constants.dart';
import 'package:sih2020/screens/add_new_vehicle_screen.dart';

class Vehicle {

  String carName;
  String lastTravelled;
  IconData icon;
  FuelTypes fuelType;
  double kilometersDriven;
  RangeValues mileage;
  DateTime serviceDate;
  DateTime buyDate;

  Vehicle({
    this.carName,
    this.lastTravelled = 'Never',
    this.icon = FontAwesomeIcons.car,
    this.mileage,
    this.buyDate,
    this.kilometersDriven,
    this.serviceDate,
    this.fuelType
  });

  Widget getVehicleAsListItem({bool selectedVehicle = false, bool expandedVehicleDetails = false, void Function(dynamic) popUpMenuOnSelected}) {
    return CustomizableCard(
      backgroundColor: selectedVehicle ? Color(0xff369df7) : Colors.white,
      titleColor: selectedVehicle ? Colors.white : Colors.black,
      gradient: selectedVehicle ? LinearGradient(
        colors: [Colors.lightBlueAccent,Colors.blue,Colors.blue.shade500,Colors.blue,Colors.lightBlueAccent]
//          colors: [Color(0xff64bbd1),Colors.blue]
      ) : null,
      icon: icon,
      title: carName,
      elevation:  selectedVehicle ? 5.0 : 0.0,
      subtext1: 'Last Travelled - $lastTravelled',
      subtextColor: selectedVehicle ? Colors.white : Colors.grey.shade600,
      popUpMenuItems: <PopupMenuItem>[
        PopupMenuItem(
          value: 'Edit',
          child: PopUpMenuContent(
            icon: FontAwesomeIcons.solidEdit,
            text: 'Edit',
          ),
        ),
        PopupMenuItem(
          value: 'Statistics',
          child: PopUpMenuContent(
            icon: FontAwesomeIcons.solidChartBar,
            text: 'Statistics',
          ),
        ),
        PopupMenuItem(
          value: 'Delete',
          child: PopUpMenuContent(
            icon: FontAwesomeIcons.trash,
            text: 'Delete',
          ),
        ),
      ],
      popUpMenuOnSelected: popUpMenuOnSelected,
//      popUpMenuOnSelected: (selectedPopUpItem) async{
//        print('$carName and $selectedPopUpItem');
//        if(selectedPopUpItem == 'Edit') {
//          Vehicle editedVehicle = await Navigator.push(context,MaterialPageRoute(
//              builder: (context) => NewVehicleScreen(this)
//          ));
//          if(editedVehicle!=null) {
//          }
//        }
//      },
      bottomWidget: selectedVehicle && expandedVehicleDetails ? Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            VehicleListItemInformationBottomWidget(
              title: 'Journeys Completed',
              value: 20,
            ),
            VehicleListItemInformationBottomWidget(
              title: 'Kilometers Travelled',
              value: 751,
              unit: 'Km',
            ),
            VehicleListItemInformationBottomWidget(
              title: 'Fuel Saved',
              value: 20,
              unit: 'L',
            ),
          ],
        ),
      ) : null,
    );
  }
}

class PopUpMenuContent extends StatelessWidget {
  final IconData icon;
  final String text;

  PopUpMenuContent({this.icon,this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          icon
        ),
        SizedBox(width: 15.0,),
        Text(
          text
        )
      ],
    );
  }
}

class VehicleListItemInformationBottomWidget extends StatelessWidget {

  final String title;
  final double value;
  final String unit;

  VehicleListItemInformationBottomWidget({this.title,this.value,this.unit = ''});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade50
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            '$value $unit',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold,
              fontSize: 22.0
            ),
          )
        ],
      ),
    );
  }
}
