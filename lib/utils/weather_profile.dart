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
    temperature = double.parse(jsonResponse['main']['temp']);
    feelsLikeTemp = double.parse(jsonResponse['main']['feels_like']);
    minTemp = double.parse(jsonResponse['main']['temp_min']);
    maxTemp = double.parse(jsonResponse['main']['temp_max']);
    windSpeed = double.parse(jsonResponse['wind']['speed']);
    windDegree = jsonResponse['wind']['deg'] as int;
    humidityPercent = jsonResponse['main']['humidity'] as int;
    atmosphericPressure = jsonResponse['main']['pressure'] as int;
  }
}