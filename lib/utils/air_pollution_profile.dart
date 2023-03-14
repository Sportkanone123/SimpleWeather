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
    carbonMonoxide = (subJsonResponse['components']['co'] as num).toDouble();
    nitrogenMonoxide = (subJsonResponse['components']['no'] as num).toDouble();
    nitrogenDioxide = (subJsonResponse['components']['no2'] as num).toDouble();
    ozone = (subJsonResponse['components']['o3'] as num).toDouble();
    sulphurDioxide = (subJsonResponse['components']['so2'] as num).toDouble();
    fineParticlesMatter = (subJsonResponse['components']['pm2_5'] as num).toDouble();
    coarseParticlesMatter = (subJsonResponse['components']['pm10'] as num).toDouble();
    ammonia = (subJsonResponse['components']['nh3'] as num).toDouble();
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