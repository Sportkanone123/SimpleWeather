import 'dart:convert';

import 'package:latlong2/latlong.dart';

class LocationProfile {
  late String name;
  late LatLng latLng;
  late String country;

  LocationProfile(this.name, this.latLng, this.country);

  LocationProfile.fromJSON(Map<String, dynamic> jsonResponse){
    name = jsonResponse['name'].toString().toLowerCase();
    latLng = LatLng(jsonResponse['lat'], jsonResponse['lon']);
    country = jsonResponse['country'];
  }

  String toJSON(){
    Map<String, dynamic> jsonObject = {};

    jsonObject['name'] = name.toLowerCase();
    jsonObject['lon'] = latLng.longitude;
    jsonObject['lat'] = latLng.latitude;
    jsonObject['country'] = country;

    return jsonEncode(jsonObject);
  }
}