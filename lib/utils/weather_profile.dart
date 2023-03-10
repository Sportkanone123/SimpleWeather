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
  late String weatherIconId;
  late String? weatherIconPath;

  late int temperature;
  late int feelsLikeTemp;
  late int minTemp;
  late int maxTemp;

  late int windSpeed;
  late int windDegree;
  late int windGust;

  late int humidityPercent;
  late int atmosphericPressure;

  WeatherProfile(
      this.time,
      this.location,
      this.sunrise,
      this.sunset,
      this.weatherDescription,
      this.weatherIconId,
      this.weatherIconPath,
      this.temperature,
      this.feelsLikeTemp,
      this.minTemp,
      this.maxTemp,
      this.windSpeed,
      this.windDegree,
      this.windGust,
      this.humidityPercent,
      this.airPollutionIndex,
      this.atmosphericPressure);

  WeatherProfile.fromJson(Map<String, dynamic> jsonResponse, AirPollutionProfile airPollution){
    time = jsonResponse['dt'] as int;
    location = LocationProfile(
        jsonResponse['name'] as String,
        LatLng(jsonResponse['coord']['lat'], jsonResponse['coord']['lon']),
        jsonResponse['country'] as String,
        null
    );
    airPollutionIndex = airPollution;
    sunrise = jsonResponse['sys']['sunrise'] as int;
    sunset = jsonResponse['sys']['sunset'] as int;
    weatherDescription = jsonResponse['weather'][0]['description'] as String;
    weatherIconId = jsonResponse['weather'][0]['icon'] as String;
    weatherIconPath = null;
    temperature = jsonResponse['main']['temp'] as int;
    feelsLikeTemp = jsonResponse['main']['feels_like'] as int;
    minTemp = jsonResponse['main']['temp_min'] as int;
    maxTemp = jsonResponse['main']['temp_max'] as int;
    windSpeed = jsonResponse['wind']['speed'] as int;
    windDegree = jsonResponse['wind']['deg'] as int;
    windGust = jsonResponse['wind']['gust'] as int;
    humidityPercent = jsonResponse['main']['humidity'] as int;
    atmosphericPressure = jsonResponse['main']['pressure'] as int;
  }
}