import 'package:flutter/material.dart';

class CustomizableCardInformationBottomWidget extends StatelessWidget {

  final String title;
  final double value;
  final String unit;
  final bool unitAfterTitle;
  final Color titleColor;

  CustomizableCardInformationBottomWidget({this.title,this.value,this.unit = '',this.unitAfterTitle=true,this.titleColor});

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
                  color: titleColor ?? Colors.green.shade50
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            unitAfterTitle==true ? '$value $unit' : '$unit $value',
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
