import 'dart:convert';

import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

import '../api_credentials.dart';
import '../air_pollution_profile.dart';
import '../location_profile.dart';
import '../weather_profile.dart';

class OpenWeatherAPI{

  Future<AirPollutionProfile> getAirPollution(LatLng latLng) async {
    final response = await http
        .get(Uri.parse('https://api.openweathermap.org/data/2.5/air_pollution?lat=${latLng.latitude}&lon=${latLng.longitude}&units=metric&appid=${APICredentials().OPEN_WEATHER_API_KEY}'));

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    return AirPollutionProfile.fromJSON(jsonResponse);
  }

  Future<WeatherProfile> getWeatherProfile(LocationProfile locationProfile, AirPollutionProfile airPollutionProfile) async {
    final response = await http
        .get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=${locationProfile.latLng.latitude}&lon=${locationProfile.latLng.longitude}&units=metric&appid=${APICredentials().OPEN_WEATHER_API_KEY}'));

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    return WeatherProfile.fromJson(jsonResponse, airPollutionProfile, locationProfile);
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
      ));
    }

    return profiles;
  }
}