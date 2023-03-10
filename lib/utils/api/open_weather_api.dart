import 'dart:convert';

import 'package:latlong2/latlong.dart';
import 'package:simple_weather/utils/air_pollution_profile.dart';
import 'package:simple_weather/utils/api_credentials.dart';
import 'package:http/http.dart' as http;
import 'package:simple_weather/utils/location_profile.dart';

import '../weather_profile.dart';

class OpenWeatherAPI{

  Future<AirPollutionProfile> getAirPollution(LatLng latLng) async {
    final response = await http
        .get(Uri.parse('https://api.openweathermap.org/data/2.5/air_pollution?lat=${latLng.latitude}&lon=${latLng.longitude}&units=metric&appid=${APICredentials().OPEN_WEATHER_API_KEY}'));

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    return AirPollutionProfile.fromJSON(jsonResponse);
  }

  Future<WeatherProfile> getWeatherProfile(LatLng latLng) async {
    AirPollutionProfile airPollution = await getAirPollution(latLng);

    final response = await http
        .get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=${latLng.latitude}&lon=${latLng.longitude}&units=metric&appid=${APICredentials().OPEN_WEATHER_API_KEY}'));

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    return WeatherProfile.fromJson(jsonResponse, airPollution);
  }

  Future<List<LocationProfile>> getLocationProfile(String query, int limit) async{
    final response = await http
        .get(Uri.parse('http://api.openweathermap.org/geo/1.0/direct?q=$query&limit=$limit&appid=${APICredentials().OPEN_WEATHER_API_KEY}'));

    List<dynamic> jsonResponse = jsonDecode(response.body);

    List<LocationProfile> profiles = <LocationProfile>[];

    for (var element in jsonResponse) {
      Map<String,dynamic> jsonObject = element;

      profiles.add(LocationProfile(
        jsonObject['name'] as String,
        LatLng(jsonObject['lat'], jsonObject['lon']),
        jsonObject['country'] as String,
        jsonObject['state'] as String,
      ));
    }

    return profiles;
  }
}