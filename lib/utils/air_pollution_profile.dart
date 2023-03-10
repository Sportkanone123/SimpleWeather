import 'package:latlong2/latlong.dart';

class AirPollutionProfile {
  late int time;
  late LatLng location;

  late int airPollutionIndex;

  late int carbonMonoxide;
  late int nitrogenMonoxide;
  late int nitrogenDioxide;
  late int ozone;
  late int sulphurDioxide;
  late int fineParticlesMatter;
  late int coarseParticlesMatter;
  late int ammonia;

  AirPollutionProfile(
      this.time,
      this.location,
      this.airPollutionIndex,
      this.carbonMonoxide,
      this.nitrogenMonoxide,
      this.nitrogenDioxide,
      this.ozone,
      this.sulphurDioxide,
      this.fineParticlesMatter,
      this.coarseParticlesMatter,
      this.ammonia);
  
  AirPollutionProfile.fromJSON(Map<String, dynamic> jsonResponse){
    Map<String, dynamic> subJsonResponse = jsonResponse['list'][0] as Map<String, dynamic>;

    time = subJsonResponse['dt'] as int;
    location = LatLng(jsonResponse['coord']['lat'] as double, jsonResponse['coord']['lon'] as double);
    airPollutionIndex = subJsonResponse['main']['aqi'] as int;
    carbonMonoxide = subJsonResponse['components']['co'] as int;
    nitrogenMonoxide = subJsonResponse['components']['no'] as int;
    nitrogenDioxide = subJsonResponse['components']['no2'] as int;
    ozone = subJsonResponse['components']['o3'] as int;
    sulphurDioxide = subJsonResponse['components']['so2'] as int;
    fineParticlesMatter = subJsonResponse['components']['pm2_5'] as int;
    coarseParticlesMatter = subJsonResponse['components']['pm10'] as int;
    ammonia = subJsonResponse['components']['nh3'] as int;
  }
}