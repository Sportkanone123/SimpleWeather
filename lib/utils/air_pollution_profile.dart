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
    carbonMonoxide = double.parse(subJsonResponse['components']['co']);
    nitrogenMonoxide = double.parse(subJsonResponse['components']['no']);
    nitrogenDioxide = double.parse(subJsonResponse['components']['no2']);
    ozone = double.parse(subJsonResponse['components']['o3']);
    sulphurDioxide = double.parse(subJsonResponse['components']['so2']);
    fineParticlesMatter = double.parse(subJsonResponse['components']['pm2_5']);
    coarseParticlesMatter = double.parse(subJsonResponse['components']['pm10']);
    ammonia = double.parse(subJsonResponse['components']['nh3']);
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