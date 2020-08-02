import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReviewScreen extends StatefulWidget {
  static String screenID = 'review_screen';

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
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
                    initialRating: 3,
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
                      print(rating);
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
                          Row(
                            children: <Widget>[
                              Icon(FontAwesomeIcons.foursquare),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Washroom'),
                            ],
                          ),
                          YesNoDropDown(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(Icons.looks_one),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Air Pump'),
                            ],
                          ),
                          YesNoDropDown(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(Icons.looks_one),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Restaurant Nearby'),
                            ],
                          ),
                          YesNoDropDown(),
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
                            decoration: InputDecoration(
                                border: InputBorder.none, hintText: 'Feedback'),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      onPressed: () {},
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

class YesNoDropDown extends StatefulWidget {

  @override
  _YesNoDropDownState createState() => _YesNoDropDownState();
}

class _YesNoDropDownState extends State<YesNoDropDown> {
  String dropdownValue = 'Yes';

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
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items:
      <String>['Yes', 'No'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

