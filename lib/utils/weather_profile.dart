import 'package:latlong2/latlong.dart';

import 'air_pollution_profile.dart';
import 'location_profile.dart';

class WeatherProfile {
  late int time;

  late LocationProfile location;
  late AirPollutionProfile airPollutionIndex;

  late int sunrise;
  late int sunset;

  late String weatherDescription;
  late int weatherId;

  late double temperature;
  late double feelsLikeTemp;
  late double minTemp;
  late double maxTemp;

  late double windSpeed;
  late int windDegree;

  late int humidityPercent;
  late int atmosphericPressure;

  WeatherProfile(
      this.time,
      this.location,
      this.sunrise,
      this.sunset,
      this.weatherDescription,
      this.weatherId,
      this.temperature,
      this.feelsLikeTemp,
      this.minTemp,
      this.maxTemp,
      this.windSpeed,
      this.windDegree,
      this.humidityPercent,
      this.airPollutionIndex,
      this.atmosphericPressure);

  WeatherProfile.fromJson(Map<String, dynamic> jsonResponse, AirPollutionProfile airPollution, LocationProfile locationProfile){
    time = jsonResponse['dt'] as int;
    location = locationProfile;
    airPollutionIndex = airPollution;
    sunrise = jsonResponse['sys']['sunrise'] as int;
    sunset = jsonResponse['sys']['sunset'] as int;
    weatherDescription = jsonResponse['weather'][0]['description'] as String;
    weatherId = jsonResponse['weather'][0]['id'] as int;
    temperature = (jsonResponse['main']['temp'] as num).toDouble();
    feelsLikeTemp = (jsonResponse['main']['feels_like'] as num).toDouble();
    minTemp = (jsonResponse['main']['temp_min'] as num).toDouble();
    maxTemp = (jsonResponse['main']['temp_max'] as num).toDouble();
    windSpeed = (jsonResponse['wind']['speed'] as num).toDouble();
    windDegree = jsonResponse['wind']['deg'] as int;
    humidityPercent = jsonResponse['main']['humidity'] as int;
    atmosphericPressure = jsonResponse['main']['pressure'] as int;
  }
}