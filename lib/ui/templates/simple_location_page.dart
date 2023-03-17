import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:simple_weather/utils/simple_weather_profile.dart';
import 'package:simple_weather/utils/string_extension.dart';

import '../../utils/icon_provider.dart';
import '../constants.dart';

class SimpleLocationPage extends StatelessWidget {
  final SimpleWeatherProfile simpleWeatherProfile;

  const SimpleLocationPage({super.key, required this.simpleWeatherProfile});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 144,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(11)),
        color: kPrimaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 120,
                margin: const EdgeInsets.only(top: 25, left: 20),
                child: AutoSizeText("${simpleWeatherProfile.location.name.capitalize()}, ${simpleWeatherProfile.location.country}", maxLines: 1, maxFontSize: 20, textAlign: TextAlign.center, style: const TextStyle(color: kTextSecondaryColor, fontSize: 20, fontWeight: FontWeight.w600, fontFamily: "Poppins")),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 25, left: 20),
                child: Text("${simpleWeatherProfile.temperature.round()}°", textAlign: TextAlign.center, style: const TextStyle(color: kTextSecondaryColor, fontSize: 60, fontWeight: FontWeight.w500, fontFamily: "Poppins")),
              ),
            ],
          ),
          Container(
            height: 113,
            width: 89,
            margin: const EdgeInsets.only(bottom: 25,  right: 30),
            child: IconProvider().getSmallWeatherIcon(simpleWeatherProfile.weatherId),
          ),
        ],
      ),
    );
  }
}