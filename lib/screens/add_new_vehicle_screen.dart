import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sih2020/components/vehicle.dart';
import 'package:sih2020/constants.dart';

const double maxKilometersDriven = 1000.0;
const double minKilometersDriven = 0.0;
const double maxMileage = 40.0;
const double minMileage = 0.0;
const FuelTypes initialFuelType = FuelTypes.Petrol;

class NewVehicleScreen extends StatefulWidget {

  final Vehicle vehicle;
  NewVehicleScreen(this.vehicle);

  @override
  _NewVehicleScreenState createState() => _NewVehicleScreenState();
}

class _NewVehicleScreenState extends State<NewVehicleScreen> {
  Vehicle vehicle;
  String carName;
  FuelTypes fuelType;
  double kilometersDriven;
  RangeValues mileage;
  DateTime serviceDate;
  DateTime buyDate;

  @override
  void initState() {
    super.initState();
    vehicle = widget.vehicle;
    carName = vehicle.carName;
    fuelType = vehicle.fuelType ?? initialFuelType;
    kilometersDriven = vehicle.kilometersDriven ?? maxKilometersDriven;
    mileage = vehicle.mileage ?? RangeValues(minMileage,maxMileage);
    serviceDate = vehicle.serviceDate;
    buyDate = vehicle.buyDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text(
            'Vehicle Information'
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              if (carName == null) {
                print('Please type a car name. ');
              }
              else{
                vehicle.carName=carName;
                vehicle.fuelType=fuelType;
                vehicle.kilometersDriven=kilometersDriven;
                vehicle.mileage=mileage;
                vehicle.serviceDate=serviceDate;
                vehicle.buyDate=buyDate;
                Navigator.pop(
                    context,
                    vehicle
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(
                    FontAwesomeIcons.carAlt
                ),
                title: TextField(
                  cursorColor: Colors.green,
                  controller: TextEditingController()..text = carName,
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
              ListTile(
                leading: Icon(
                    FontAwesomeIcons.gasPump
                ),
                title: DropdownButton<FuelTypes>(
                  onChanged: (FuelTypes fuel) {
                    setState(() {
                      fuelType=fuel;
                    });
                  },
                  value: fuelType,
                  items: FuelTypes.values.map<DropdownMenuItem<FuelTypes>>((FuelTypes fuel) {
                    return DropdownMenuItem<FuelTypes>(
                      value: fuel,
                      child: Text(
                        fuel.toString().split('.')[1],
                        style: TextStyle(
                          fontSize: 18.0
                        ),
                      ),
                    );
                  }).toList()
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0,bottom: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 15.9),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            'Kilometers Driven',
                            style: TextStyle(
                              fontSize: 19.0,
                            ),
                          ),
                          Text(
                            '${kilometersDriven.floor()} Km',
                            style: TextStyle(
                              fontSize: 18.0
                            ),
                          )
                        ],
                      ),
                    ),
                    Slider(
                      onChanged: (double value) {
                        setState(() {
                          kilometersDriven = value;
                        });
                      },
                      min: minKilometersDriven,
                      max: maxKilometersDriven,
                      divisions: 13,
                      value: kilometersDriven,
                      label: '${kilometersDriven.floor()}',
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 15.9),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            'Mileage',
                            style: TextStyle(
                              fontSize: 19.0,
                            ),
                          ),
                          Text(
                            '${'${mileage.start.floor()} - ${mileage.end.floor()}'} kmpl',
                            style: TextStyle(
                                fontSize: 18.0
                            ),
                          )
                        ],
                      ),
                    ),
                    RangeSlider(
                      onChanged: (RangeValues values) {
                        setState(() {
                          mileage = values;
                        });
                      },
                      min: minMileage,
                      max: maxMileage,
                      divisions: 8,
                      values: mileage,
                      labels: RangeLabels('${mileage.start.floor()}','${mileage.end.floor()}'),
                    )
                  ],
                ),
              ),
              ListTile(
                leading: Icon(
                    FontAwesomeIcons.calendar
                ),
                title: RaisedButton(
                  color: buyDate!=null ? Colors.lightBlueAccent : null,
                  onPressed: () async{
                    DateTime picked = await showDatePicker(
                      context: context,
                      initialDate: buyDate ?? DateTime.now(),
                      firstDate: DateTime(1980),
                      lastDate: DateTime.now(),
                    );
                    if (picked!=null && buyDate!=picked) {
                      setState(() {
                        buyDate = picked;
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Car bought on ',
                          style: TextStyle(
                              fontSize: 16
                          ),
                        ),
                        buyDate != null ? Text(
                          '${buyDate.toLocal()}'.split(' ')[0],
                          style: TextStyle(
                              fontSize: 19
                          ),
                        ):SizedBox()
                      ],
                    ),
                  ),
                ),
                trailing: buyDate != null ? InkWell(
                  onTap: () {
                    setState(() {
                      buyDate = null;
                    });
                  },
                  child: Icon(
                      Icons.close
                  ),
                ):null,
              ),
              ListTile(
                leading: Icon(
                    FontAwesomeIcons.carCrash
                ),
                title: RaisedButton(
                  color: serviceDate!=null ? Colors.lightBlueAccent : null,
                  onPressed: () async{
                    DateTime picked = await showDatePicker(
                        context: context,
                        initialDate: serviceDate ?? DateTime.now(),
                        firstDate: DateTime(1980),
                        lastDate: DateTime.now(),
                    );
                    if (picked!=null && serviceDate!=picked) {
                      setState(() {
                        serviceDate = picked;
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Last Service',
                          style: TextStyle(
                            fontSize: 16
                          ),
                        ),
                        serviceDate != null ? Text(
                          '${serviceDate.toLocal()}'.split(' ')[0],
                          style: TextStyle(
                            fontSize: 19
                          ),
                        ):SizedBox()
                      ],
                    ),
                  ),
                ),
                trailing: serviceDate != null ? InkWell(
                  onTap: () {
                    setState(() {
                      serviceDate = null;
                    });
                  },
                  child: Icon(
                    Icons.close
                  ),
                ):null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

