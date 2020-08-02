import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const double initialPumpRating = 3;

class ReviewScreen extends StatefulWidget {
  static String screenID = 'review_screen';

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {

  double pumpRating = initialPumpRating;
  bool washroom = true;
  bool airPump = true;
  bool restaurantNearby = true;
  String feedback = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Review'),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.lightGreen,
                height: 100,
                width: double.infinity,
                child: Center(
                    child: Text(
                  'Hindustan Petroleum',
                  style: TextStyle(fontSize: 30),
                )),
              ),
              SizedBox(
                child: Divider(
                  thickness: 0,
                  height: 5,
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'Rate     -',
                    style: TextStyle(fontSize: 20),
                  ),
                  RatingBar(
                    initialRating: initialPumpRating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      pumpRating=rating;
                    },
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                height: 17,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        color: Colors.tealAccent,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Facilities',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Washroom',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          YesNoDropDown(
                            dropdownValue: washroom?'Yes' : 'No',
                            onChanged: (String newValue) {
                              setState(() {
                                washroom = newValue=='Yes' ? true:false;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Air Pump',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          YesNoDropDown(
                            dropdownValue: airPump?'Yes' : 'No',
                            onChanged: (String newValue) {
                              setState(() {
                                airPump = newValue=='Yes' ? true:false;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Restaurant Nearby',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          YesNoDropDown(
                            dropdownValue: restaurantNearby?'Yes' : 'No',
                            onChanged: (String newValue) {
                              setState(() {
                                restaurantNearby = newValue=='Yes' ? true:false;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        height: 100,
                        color: Colors.grey,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: TextField(
                            maxLines: 4,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                                filled: true,
                                border: InputBorder.none, hintText: 'Feedback'),
                            onChanged: (String feedbackText) {
                              feedback=feedbackText;
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      onPressed: () {
                        ReviewResponse reviewResponse = ReviewResponse(
                          pumpRating: pumpRating,
                          washroom: washroom,
                          airPump: airPump,
                          restaurantNearby: restaurantNearby,
                        );

                        // Call Post API to submit reviews in the backend
                        // To access user inputs use reviewResponse object created above,
                        // reviewResponse.pumpRating will give double
                        // reviewResponse.washroom will give bool
                        // reviewResponse.airPump will give bool
                        // reviewResponse.restaurantNearby will give bool
                      },
                      child: Text('Submit', style: TextStyle(fontSize: 20)),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}

class YesNoDropDown extends StatelessWidget {
  final String dropdownValue;
  final Function(String) onChanged;

  YesNoDropDown({
    this.dropdownValue = 'Yes',
    @required this.onChanged
});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: onChanged,
      items:
      <String>['Yes', 'No'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class ReviewResponse {
  double pumpRating;
  bool washroom;
  bool airPump;
  bool restaurantNearby;
  String feedback;

  ReviewResponse({this.restaurantNearby,this.airPump,this.washroom,this.feedback,this.pumpRating});
}