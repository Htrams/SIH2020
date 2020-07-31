import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sih2020/components/customizable_card.dart';
import 'package:sih2020/components/fuel_stations.dart';
import 'package:sih2020/constants.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:sih2020/components/customizable_card_information_bottom_widget.dart';

const double minHeight= 80.0;

class RedScreen extends StatefulWidget {
  static String screenID = 'red_screen';

  @override
  _RedScreenState createState() => _RedScreenState();
}

List<FuelStation> stations = <FuelStation>[
  FuelStation(
    stationName: 'Indian Oil',
    rating: 3.5,
  ),
  FuelStation(
    stationName: 'Hindustan Petroleum',
    rating: 5.0,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('Fuel Critical'),
        centerTitle: true,
      ),
      body: SlidingUpPanel(
        renderPanelSheet: true,
        parallaxEnabled: true,
        parallaxOffset: .5,
        backdropEnabled: true,
        minHeight: minHeight,
        borderRadius: radius,
        header: Container(
          height: minHeight,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.redAccent.shade200,
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
                        'Refuel on the next gas Station',
                        style: TextStyle(
                          fontSize: 16.0
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                Icon(
                  FontAwesomeIcons.angleUp,
                  size: 35,
                )
              ],
            ),
          ),
        ),
        panel: Container(
          padding: EdgeInsets.only(top: minHeight),
          child: ListView.separated(
            padding: EdgeInsets.all(10.0),
            itemCount: stations.length,
            itemBuilder: (context, int index) {
              return CustomizableCard(
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
                      title: 'Estimated Time',
                      titleColor: Colors.grey,
                      value: 5,
                      unit: 'Km',
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context,int index) {
              return Divider();
            },
          ),
        ),
        body: Center(
          child: Text('Map'),
        ),
      ),
    );
  }
}
