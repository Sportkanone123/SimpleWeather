import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:simple_weather/ui/constants.dart';
import 'package:simple_weather/ui/templates/location_page.dart';
import 'package:simple_weather/ui/templates/location_skeleton_page.dart';
import 'package:simple_weather/utils/air_pollution_profile.dart';
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

  final List<Widget> _pages = List.generate(3,
          (index) => LocationPage(weatherProfile: WeatherProfile.fromJson(jsonDecode('{"coord":{"lon":9.748,"lat":48.0878},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04d"}],"base":"stations","main":{"temp":6.69,"feels_like":1.45,"temp_min":5.62,"temp_max":8.05,"pressure":1006,"humidity":59},"visibility":10000,"wind":{"speed":11.62,"deg":259},"clouds":{"all":75},"dt":1678809694,"sys":{"type":2,"id":2035370,"country":"DE","sunrise":1678772238,"sunset":1678814610},"timezone":3600,"id":2870795,"name":"Mittelbiberach","cod":200}')
              , AirPollutionProfile.fromJSON(jsonDecode('{"coord":{"lon":9.748,"lat":48.0878},"list":[{"main":{"aqi":1},"components":{"co":210.29,"no":0.05,"no2":3.64,"o3":54.36,"so2":0.3,"pm2_5":0.5,"pm10":0.69,"nh3":5.19},"dt":1678640657}]}'))
              , LocationProfile.fromJSON(jsonDecode('{"name":"Mittelbiberach","lat":48.0877864,"lon":9.7479621,"country":"DE","state":"Baden-Württemberg"}')))));

  @override
  Widget build(BuildContext context) {
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
          height: MediaQuery.of(context).size.height - 170,
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
  }
}