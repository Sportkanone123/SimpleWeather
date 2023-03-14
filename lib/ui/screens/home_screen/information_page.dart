import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_weather/ui/constants.dart';
import 'package:simple_weather/ui/templates/location_page.dart';
import 'package:simple_weather/ui/templates/location_skeleton_page.dart';
import 'package:simple_weather/utils/air_pollution_profile.dart';
import 'package:simple_weather/utils/api/open_weather_api.dart';
import 'package:simple_weather/utils/location_profile.dart';
import 'package:simple_weather/utils/weather_profile.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class InformationPage extends StatefulWidget{
  const InformationPage({super.key});

  @override
  InformationPageState createState() => InformationPageState();
}

class InformationPageState extends State<InformationPage> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  bool hasLoaded = false;

  late SharedPreferences prefs;
  List<Widget> _pages = List.generate(1, (index) => Container());


  @override
  void initState() {
    super.initState();

    refresh();
  }

  Future<void> refresh() async {
    setState(() {
      hasLoaded = false;
    });

    prefs = await SharedPreferences.getInstance();

    prefs.setString('Mittelbiberach', '{"name":"Mittelbiberach","lon":9.748,"lat":48.0878,"country":"DE"}');
    prefs.setString('Aeschi bei Spiez', '{"name":"Aeschi bei Spiez","lon":7.6965086,"lat":46.6583588,"country":"CH"}');

    Set<String> keys = prefs.getKeys();

    _pages = List.generate(keys.length, (index) => const LocationSkeletonPage());

    List<Widget> locationWidgets = [];

    for(String key in keys){
      LocationProfile locationProfile = LocationProfile.fromJSON(jsonDecode(prefs.getString(key)!));
      AirPollutionProfile airPollutionProfile = await OpenWeatherAPI().getAirPollution(locationProfile.latLng);
      WeatherProfile weatherProfile = await OpenWeatherAPI().getWeatherProfile(locationProfile, airPollutionProfile);

      locationWidgets.add(LocationPage(weatherProfile: weatherProfile));
    }

    setState(() {
      _pages.clear();
      _pages.addAll(locationWidgets);

      hasLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_pages.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 22,
            width: _pages.length * 20 + 18,
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: kPrimaryColor,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            alignment: Alignment.center,
            child: SmoothPageIndicator(
              controller: controller,
              count: _pages.length,
              effect: const WormEffect(
                dotHeight: 8,
                dotWidth: 8,
                spacing: 12,
                type: WormType.normal,
                // strokeWidth: 5,
              ),
            ),
          ),

          const SizedBox(height: 41),

          SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height - 170,
            child: PageView.builder(
              controller: controller,
              scrollDirection: Axis.horizontal,
              itemCount: _pages.length,
              padEnds: true,
              pageSnapping: true,
              itemBuilder: (context, index) {
                return SingleChildScrollView(child: _pages[index]);
              },
            ),
          ),
        ],
      );
    } else {
      return Container(
        alignment: Alignment.center,
        child: const Text("No locations added!", style: TextStyle(fontSize: 22,
            fontWeight: FontWeight.w600,
            fontFamily: "Poppins",
            color: kTextPrimaryColor)),
      );
    }
  }
}