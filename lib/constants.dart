import 'package:flutter/material.dart';

enum FuelTypes {
  Petrol,
  Diesel,
  CNG,
  LPG,
  Electric
}

enum mode{
  red,
  yellow,
  green
}

class Mode {
  final Color color;
  final String title;
  final String message;

  Mode({
    this.color,
    this.title,
    this.message
  });
}
Mode green = Mode(
    color: Colors.greenAccent,
    title: 'Going Good',
    message: 'Fuel is okay.'
);
Mode yellow = Mode(
    color: Colors.yellow.shade500,
    title: 'Fuel low',
    message: 'Refuel as per convenience.'
);
Mode red = Mode(
    color: Colors.redAccent,
    title: 'Fuel Critical',
    message: 'Refuel on the next gas station'
);

Map<mode,Mode> modeInfo = {
  mode.green : green,
  mode.yellow: yellow,
  mode.red: red,
};