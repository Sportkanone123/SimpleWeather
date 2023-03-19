import 'package:flutter/material.dart';
import 'package:simple_weather/ui/screens/location_view_screen/header.dart';
import 'package:simple_weather/ui/templates/location_page.dart';
import 'package:simple_weather/utils/profile/weather_profile.dart';

import '../../constants.dart';

class LocationViewScreen extends StatelessWidget{
  const LocationViewScreen({super.key, required this.profile});

  final WeatherProfile profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        children: [
          Header(weatherProfile: profile,),
          Expanded(
              child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.only(left: kDefaultPadding * 0.5, right: kDefaultPadding * 0.5),
                    child: LocationPage(weatherProfile: profile),
                  )
              )
          )
        ],
      )
    );
  }
}