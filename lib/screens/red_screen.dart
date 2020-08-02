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
import 'package:geocoder/geocoder.dart';
import 'dart:async';

const double minHeight= 80.0;

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

  mode activeMode = mode.green;
  int pumpMoreDetails = -1;

  PanelController slidingPanelController = PanelController();

  GoogleMapController mapController;
  static final LatLng _initialCenter = const LatLng(20.1492, 85.6652);
  LatLng _currentCenter = _initialCenter;
  String _currentAddress;
  Set<Marker> _marker;


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
  @override
  void initState() {
    super.initState();
    const oneSec = const Duration(seconds:20);
    new Timer.periodic(oneSec, (Timer t) {
      if (activeMode == mode.green) {
        activeMode=mode.yellow;
      }
      else if(activeMode == mode.yellow) {
        activeMode=mode.red;
      }
      setState(() {
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: modeInfo[activeMode].color,
        title: Text(
            modeInfo[activeMode].title
        ),
        centerTitle: true,
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
                  if (pumpMoreDetails!=-1 && pumpMoreDetails==index)
                    pumpMoreDetails=-1;
                  else
                    pumpMoreDetails=index;
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
                  openExpandableWidget: pumpMoreDetails == index,
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
                  var address = await Geocoder.local.findAddressesFromCoordinates(Coordinates(_currentCenter.latitude,_currentCenter.longitude));
                  _currentAddress = '${address.first.addressLine}';
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}

