import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sih2020/screens/red_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sih2020/services/map_helper_functions.dart';

const double upperAreaHeight=200.0;

class DestinationScreen extends StatefulWidget {
  @override
  _DestinationScreenState createState() => _DestinationScreenState();
  static String screenID = 'destination_screen';
}

class _DestinationScreenState extends State<DestinationScreen> {

  GoogleMapController mapController;
  static final LatLng _initialCenter = const LatLng(20.1492, 85.6652);
  String _initialAddress;
  LatLng _currentCenter = _initialCenter;
  String _currentAddress;
  Set<Marker> _marker;
  TextEditingController _textEditingController = TextEditingController();
  FocusNode _focusNode = FocusNode();
  MapHelper _mapHelper = MapHelper();

  Future<void> getInitialData() async {
    String displayName = await _mapHelper.getNameFromLatLong(_initialCenter);
    _initialAddress = displayName;
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) _textEditingController.clear();
    });

    getInitialData();
  }

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
            'Enter Destination',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 23.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        centerTitle: true,
      ),
      resizeToAvoidBottomPadding: false,
      floatingActionButton: Align(
        alignment: Alignment.centerRight,
        child: FloatingActionButton(
          onPressed: () {
            // Send data using the Navigator
            Navigator.pushNamed(context, RedScreen.screenID);
          },
          child: Icon(
            FontAwesomeIcons.arrowRight
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: upperAreaHeight),
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: _initialCenter,
                zoom: 15.0
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
                String displayName = await _mapHelper.getNameFromLatLong(_currentCenter);
                _currentAddress = displayName;
              },
            ),
          ),
          Container(
            height: upperAreaHeight,
            color: Colors.white,
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
//                  Row(
//                    children: [
//                      Icon(
//                        Icons.gps_fixed,
//                        size: 25.0,
//                        color: Colors.blue,
//                      ),
//                      Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: Container(
//                          child: Text(
//                            'Location',
//                            style: TextStyle(
//                              fontSize: 25,
//                              color: Colors.blue,
//                            ),
//                          ),
//                        ),
//                      )
//                    ],
//                  ),
                  TextField(
                    controller: TextEditingController()..text = _initialAddress,
                    enabled: false,
                    decoration: InputDecoration(
                      icon: Icon(
                        FontAwesomeIcons.circleNotch,
                        color: Colors.blue,
                      ),
                      hintText: "Current Location",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0.0)),
                        borderSide: BorderSide(
                          color: Colors.blue.shade600,
                        ),
                      ),
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    onEditingComplete: () async{
                      FocusScope.of(context).unfocus();
                      LatLng namedCoord = await _mapHelper.getLatLongFromName(_textEditingController.text);
                      _currentCenter=namedCoord;
                      mapController.animateCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(
                            target: _currentCenter,
                            zoom: 11.0
                        ),
                      ));
                    },
                    focusNode: _focusNode,
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      icon: Icon(
                        FontAwesomeIcons.mapMarked,
                        color: Colors.blue,
                      ),
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
                      fillColor: Colors.white,
                    ),
                  ),

//                    Text(
//                      'or',
//                      textAlign: TextAlign.center,
//                      style: TextStyle(
//                        color: Colors.grey,
//                        fontSize: 20.0,
//                      ),
//                    ),
                  SizedBox(
                    height: 3.0,
                  ),
                  FlatButton.icon(
                      shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      onPressed: () {
                        _textEditingController.text = _currentAddress;
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}