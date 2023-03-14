import 'package:latlong2/latlong.dart';

class AirPollutionProfile {
  late int time;
  late LatLng location;

  late int airPollutionIndex;

  late double carbonMonoxide;
  late double nitrogenMonoxide;
  late double nitrogenDioxide;
  late double ozone;
  late double sulphurDioxide;
  late double fineParticlesMatter;
  late double coarseParticlesMatter;
  late double ammonia;

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
    carbonMonoxide = subJsonResponse['components']['co'] as double;
    nitrogenMonoxide = subJsonResponse['components']['no'] as double;
    nitrogenDioxide = subJsonResponse['components']['no2'] as double;
    ozone = subJsonResponse['components']['o3'] as double;
    sulphurDioxide = subJsonResponse['components']['so2'] as double;
    fineParticlesMatter = subJsonResponse['components']['pm2_5'] as double;
    coarseParticlesMatter = subJsonResponse['components']['pm10'] as double;
    ammonia = subJsonResponse['components']['nh3'] as double;
  }

  String getAirPollutionName(){
    switch (airPollutionIndex){
      case 1:
        return "GOOD";
      case 2:
        return "FAIR";
      case 3:
        return "MODEST";
      case 4:
        return "POOR";
      case 5:
        return "BAD";
      default:
        return "UNKNOWN";
    }
  }
}