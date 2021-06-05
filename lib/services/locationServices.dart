import 'package:skyva/globalsAndConstants.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  Future<bool> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      gLatitude = position.latitude.toString();
      gLongitude = position.longitude.toString();

      print("Postion is ($gLatitude, $gLongitude) ");
      return true;
    } catch (e) {
      print("Get Location Error $e");
      return (false);
    }
  }
}