import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sih2020/components/customizable_card.dart';
import 'package:sih2020/constants.dart';
import 'customizable_card_information_bottom_widget.dart';

class Vehicle {

  String carName;
  String lastTravelled;
  IconData icon;
  FuelTypes fuelType;
  double tankCapacity;
  double kilometersDriven;
  RangeValues mileage;
  double finalMileage;
  DateTime serviceDate;
  DateTime buyDate;

  Vehicle({
    this.carName,
    this.lastTravelled = 'Never',
    this.icon = FontAwesomeIcons.car,
    this.mileage,
    this.finalMileage,
    this.buyDate,
    this.kilometersDriven,
    this.serviceDate,
    this.fuelType,
    this.tankCapacity
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
//      subtext1: 'Last Travelled - $lastTravelled',
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
      bottomWidget: selectedVehicle && expandedVehicleDetails ? Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            CustomizableCardInformationBottomWidget(
              title: 'Mileage',
              value: finalMileage,
            ),
            CustomizableCardInformationBottomWidget(
              title: 'Tank Capacity',
              value: tankCapacity.floorToDouble(),
              unit: 'L',
            ),
            CustomizableCardInformationBottomWidget(
              title: 'Fuel Type',
              textValue: fuelType.toString().split('.')[1],
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