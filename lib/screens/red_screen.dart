import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sih2020/components/customizable_card.dart';
import 'package:sih2020/components/fuel_stations.dart';
import 'package:sih2020/constants.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:sih2020/components/customizable_card_information_bottom_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sih2020/services/map_helper_functions.dart';
import 'dart:async';
import 'package:sih2020/screens/end_journey_screen.dart';

const double minHeight= 80.0;
const int initialFuel = 10;
const int initialDistancetoDestination = 100;

class RedScreen extends StatefulWidget {
  static String screenID = 'red_screen';

  @override
  _RedScreenState createState() => _RedScreenState();
}

List<FuelStation> stations = <FuelStation>[
  FuelStation(
    stationName: 'Indian Oil',
    rating: 5,
  ),
  FuelStation(
    stationName: 'Hindustan Petroleum',
    rating: 4.5,
  ),
  FuelStation(
    stationName: 'Oil India',
    rating: 2.0,
  ),
];

class _RedScreenState extends State<RedScreen> {

  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(30.0),
    topRight: Radius.circular(30.0),
  );

  mode activeMode = mode.unknown;
  int _pumpMoreDetails = -1;

  PanelController slidingPanelController = PanelController();
  Timer timer;

  GoogleMapController mapController;
  static final LatLng _initialCenter = const LatLng(20.1492, 85.6652);
  LatLng _currentCenter = _initialCenter;
  String _currentAddress;
  Set<Marker> _marker;

  MapHelper _mapHelper = MapHelper();
  int fuelRemaining = initialFuel;
  int distanceRemaining = initialDistancetoDestination;
  int mileage;
  int distanceAllowed;



  TableRow getCheckedTwoColumnTableRow(String text, bool check) {
    return TableRow(
        children: <Widget>[
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 17.0
              ),
            ),
          ),
          TableCell(
            child: check ?
              Icon(
                FontAwesomeIcons.check,
                color: Colors.green,
              ):
              Icon(
                Icons.close,
                color: Colors.red,
                size: 30.0,
              )
          )
        ]
    );
  }

  mode _modeStringToEnum(String text) {
    if(text=='Red') {
      return mode.red;
    }
    else if(text=='Yellow') {
      return mode.yellow;
    }
    else if(text=='Green') {
      return mode.green;
    }
    else {
      return null;
    }
  }

  Future<void> updateVehicleStatus() async{
    var statusData = await _mapHelper.getVehicleStatusData(
      fuelRemaining: fuelRemaining,
      distanceRemaining: distanceRemaining
    );
    fuelRemaining=statusData['fuelRemaining'] - 1;
    distanceRemaining=statusData['distanceRemaining'] - 10;
    mileage=statusData['mileage'];
    distanceAllowed=statusData['distanceAllowed'];
    activeMode=_modeStringToEnum(statusData['mode']);
    setState(() {

    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }


  @override
  void initState() {
    super.initState();
    const duration = const Duration(seconds:10);
    timer = Timer.periodic(duration, (Timer t) {
      updateVehicleStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: modeInfo[activeMode].color,
        title: Text(
            modeInfo[activeMode].title,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(
                    builder: (context) => EndJourneyScreen()));
                timer.cancel();
              },
              child: Row(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.windowClose,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    'End',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      body: SlidingUpPanel(
        controller: slidingPanelController,
        renderPanelSheet: true,
        parallaxEnabled: true,
        parallaxOffset: .5,
        backdropEnabled: true,
        minHeight: minHeight,
        borderRadius: radius,
        header: GestureDetector(
          onTapDown: (details) async{
            if(slidingPanelController.isPanelOpen) {
              await slidingPanelController.close();
            }
            else {
              await slidingPanelController.open();
            }
            setState(() {

            });
          },
          child: Container(
            height: minHeight,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: modeInfo[activeMode].color,
              borderRadius: radius
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          'Suggested Fuel Pumps',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize:20.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          modeInfo[activeMode].message,
                          style: TextStyle(
                            fontSize: 16.0
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                  Icon(
                    slidingPanelController.isAttached && slidingPanelController.isPanelOpen ? FontAwesomeIcons.angleDown : FontAwesomeIcons.angleUp,
                    size: 35,
                  )
                ],
              ),
            ),
          ),
        ),
        panel: Container(
          padding: EdgeInsets.only(top: minHeight),
          child: ListView.separated(
            padding: EdgeInsets.all(10.0),
            itemCount: stations.length,
            itemBuilder: (context, int index) {
              return GestureDetector(
                onTap: () {
                  if (_pumpMoreDetails!=-1 && _pumpMoreDetails==index)
                    _pumpMoreDetails=-1;
                  else
                    _pumpMoreDetails=index;
                  setState(() {
                  });
                },
                child: CustomizableCard(
                  icon: FontAwesomeIcons.gasPump,
                  title: stations[index].stationName,
                  titleSize: 25.0,
                  elevation: 7.0,
                  subWidget: SmoothStarRating(
                      allowHalfRating: true,
                      onRated: (v) {
                      },
                      starCount: 5,
                      rating: stations[index].rating,
                      size: 40.0,
                      isReadOnly:true,
                      color: Colors.green,
                      borderColor: Colors.green,
                      spacing:0.0
                  ),
                  bottomWidget: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      CustomizableCardInformationBottomWidget(
                        title: 'Expected Cost',
                        value: 100.00,
                        unit: 'Rs',
                        unitAfterTitle: false,
                        titleColor: Colors.grey,
                      ),
                      CustomizableCardInformationBottomWidget(
                        title: 'Estimated Distance',
                        titleColor: Colors.grey,
                        value: 5,
                        unit: 'Km',
                      ),
                    ],
                  ),
                  expandableWidget: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Table(
                        border: TableBorder.symmetric(
                          inside: BorderSide(color: Colors.black)
                        ),
                        children: <TableRow>[
                          getCheckedTwoColumnTableRow('Air', true),
                          getCheckedTwoColumnTableRow('Washroom', false),
                          getCheckedTwoColumnTableRow('Eatables', true)
                        ],
                      ),
                    ),
                  ),
                  openExpandableWidget: _pumpMoreDetails == index,
                ),
              );
            },
            separatorBuilder: (context,int index) {
              return Divider();
            },
          ),
        ),
        body:
        Center(
          child: Stack(
            children: <Widget>[
              GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  // Set the controller of map when it is created.
                  mapController = controller;
                },
                initialCameraPosition: CameraPosition(
                  target: _initialCenter,
                  zoom: 11.0
                ),
                markers: _marker,
                onCameraMove: (CameraPosition position) {
                  _currentCenter = position.target;
                  _marker = {
                    Marker(
                      markerId: MarkerId(_currentCenter.toString()),
                      position: _currentCenter,
                      icon: BitmapDescriptor.defaultMarker,
                      infoWindow: InfoWindow(
                        title: _currentAddress,
                      )
                    )
                  };
                  setState(() {

                  });
                },
                onCameraIdle: () async{
//                  var address = await Geocoder.local.findAddressesFromCoordinates(Coordinates(_currentCenter.latitude,_currentCenter.longitude));
//                  _currentAddress = '${address.first.addressLine}';
                },
              ),
              Container(
                height: 90.0,
                color: Color(0xEEFFFFFF),
                child: Row(
                  children: <Widget>[
                    CustomizableCardInformationBottomWidget(
                      title: 'Fuel Remaining',
                      titleColor: Colors.black,
                      titleBold: false,
                      subColor: Colors.black,
                      value: (activeMode==mode.unknown) ? null : (fuelRemaining!=null ? fuelRemaining.toDouble() : null),
                    ),
                    VerticalDivider(),
                    CustomizableCardInformationBottomWidget(
                      title: 'Distance Remaining',
                      titleColor: Colors.black,
                      titleBold: false,
                      subColor: Colors.black,
                      value: (activeMode==mode.unknown) ? null : (distanceRemaining!=null ? distanceRemaining.toDouble() : null),
                    ),
                    VerticalDivider(),
                    CustomizableCardInformationBottomWidget(
                      title: 'Distance Allowed',
                      titleColor: Colors.black,
                      titleBold: false,
                      subColor: Colors.black,
                      value: (activeMode==mode.unknown) ? null : (distanceAllowed!=null ? distanceAllowed.toDouble() : null),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

