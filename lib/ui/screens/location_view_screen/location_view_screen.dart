import 'package:flutter/material.dart';
import 'package:simple_weather/ui/screens/location_view_screen/header.dart';
import 'package:simple_weather/ui/templates/location_page.dart';
import 'package:simple_weather/utils/weather_profile.dart';

import '../../constants.dart';

class LocationViewScreen extends StatelessWidget{
  const LocationViewScreen({super.key, required this.profile});

  final WeatherProfile profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
          flexibleSpace: Header(weatherProfile: profile,),
          toolbarHeight: 145,
          backgroundColor: kBackgroundColor,
          automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: LocationPage(weatherProfile: profile),
      )
    );
  }
}