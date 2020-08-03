import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sih2020/services/network_helper.dart';

//const String apiKey = 'AIzaSyB0k69vwAGzaFIZCW7UMe16WuCj8TNjjdY';
//const String openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';
//const String geocodeURL = 'https://maps.googleapis.com/maps/api/geocode/json?';

const String locationIQ_URL = 'https://us1.locationiq.com/v1/';
const String locationIQ_apiKey = 'da8137dd3c2ac6';

const String herokuappURL = 'https://shielded-badlands-34528.herokuapp.com/';

//https://shielded-badlands-34528.herokuapp.com/user/vehicle/status/yj24/5f250a9dad769f93b9028dec

class MapHelper {

  Future<String> getNameFromLatLong(LatLng location) async {
    NetworkHelper networkHelper = NetworkHelper('${locationIQ_URL}reverse.php?key=${locationIQ_apiKey}&lat=${location.latitude}&lon=${location.longitude}&format=json');
    var networkResponse = await networkHelper.getData();
    print(networkResponse['display_name']);
    return networkResponse['display_name'];
  }


  Future<LatLng> getLatLongFromName(String locationName) async {
    NetworkHelper networkHelper = NetworkHelper('${locationIQ_URL}search.php?key=${locationIQ_apiKey}&q=${locationName}&format=json');
    var networkResponse = await networkHelper.getData();
    print(networkResponse[0]['lat']);
    return LatLng(double.parse(networkResponse[0]['lat']),double.parse(networkResponse[0]['lon']));
  }

  Future<dynamic> getVehicleStatusData({
    @required int fuelRemaining,
    @required int distanceRemaining
  }) async {
    NetworkHelper networkHelper = NetworkHelper('${herokuappURL}user/vehicle/status/yj24/5f250a9dad769f93b9028dec');
    var networkResponse = await networkHelper.postData(
      body: <String, String>{
        'fuelRemaining' : fuelRemaining.toString(),
        'distanceRemaining' : distanceRemaining.toString(),
      }
    );
    print(networkResponse);
    return networkResponse;
  }

}