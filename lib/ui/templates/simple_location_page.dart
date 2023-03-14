import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:simple_weather/utils/simple_weather_profile.dart';

import '../../utils/icon_provider.dart';
import '../constants.dart';

class SimpleLocationPage extends StatelessWidget {
  final SimpleWeatherProfile simpleWeatherProfile;

  const SimpleLocationPage({super.key, required this.simpleWeatherProfile});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 120,
              margin: const EdgeInsets.only(top: 25, left: 20),
              child: AutoSizeText("${simpleWeatherProfile.location.name}, ${simpleWeatherProfile.location.country}", maxLines: 1, maxFontSize: 20, textAlign: TextAlign.center, style: const TextStyle(color: kTextSecondaryColor, fontSize: 20, fontWeight: FontWeight.w600, fontFamily: "Poppins")),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 25, left: 20),
              child: Text("${simpleWeatherProfile.temperature}°", textAlign: TextAlign.center, style: const TextStyle(color: kTextSecondaryColor, fontSize: 60, fontWeight: FontWeight.w500, fontFamily: "Poppins")),
            ),
          ],
        ),
        Container(
          height: 113,
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 25,  right: 30),
          child: IconProvider().getWeatherIcon(simpleWeatherProfile.weatherId),
        ),
      ],
    );
  }
}