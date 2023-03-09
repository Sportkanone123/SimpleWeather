import 'package:latlong2/latlong.dart';

class LocationProfile {
  late String name;
  late LatLng latLng;
  late String country;
  late String? state;

  LocationProfile(this.name, this.latLng, this.country, this.state);
}