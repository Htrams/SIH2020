import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sih2020/services/network_helper.dart';

const String apiKey = 'AIzaSyB0k69vwAGzaFIZCW7UMe16WuCj8TNjjdY';
//const String openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';
const String geocodeURL = 'https://maps.googleapis.com/maps/api/geocode/json?';

class MapHelper {

  Future<dynamic> getNameFromLatLong(LatLng location) async {
    NetworkHelper networkHelper = NetworkHelper('${geocodeURL}latlng=${location.latitude},${location.longitude}&key=$apiKey');
    var locationData = await networkHelper.getData();
//    return locationData['results'][0]['formatted_address'];
  return locationData;
  }

}