import 'package:latlong2/latlong.dart';

import 'location_profile.dart';

class WeatherProfile {
  late int time;

  late LocationProfile location;

  late int sunrise;
  late int sunset;

  late String weatherDescription;
  late String weatherIconId;
  late String? weatherIconPath;

  late int temperature;
  late int? uvIndex;
  late int humidityPercent;
  late int airPollutionIndex;

  WeatherProfile(
      this.time,
      this.location,
      this.sunrise,
      this.sunset,
      this.weatherDescription,
      this.weatherIconId,
      this.weatherIconPath,
      this.temperature,
      this.uvIndex,
      this.humidityPercent,
      this.airPollutionIndex);




}