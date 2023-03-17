import 'location_profile.dart';

class SimpleWeatherProfile {
  late int time;

  late LocationProfile location;

  late String weatherDescription;
  late int weatherId;

  late double temperature;

  SimpleWeatherProfile(this.time, this.location, this.weatherDescription,
      this.weatherId, this.temperature);

  SimpleWeatherProfile.fromJson(Map<String, dynamic> jsonResponse, LocationProfile locationProfile){
    time = jsonResponse['dt'] as int;
    location = locationProfile;
    weatherDescription = jsonResponse['weather'][0]['description'] as String;
    weatherId = jsonResponse['weather'][0]['id'] as int;
    temperature = (jsonResponse['main']['temp'] as num).toDouble();
  }
}